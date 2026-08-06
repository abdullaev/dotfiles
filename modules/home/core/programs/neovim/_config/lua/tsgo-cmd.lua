-- Resolve the tsgo binary per project instead of pinning the Nix one.
--
-- `effect-tsgo patch` rewrites the native binaries shipped by
-- `@typescript/native-preview` and `typescript@>=7` in place, so a project-local
-- binary is either plain tsgo or the Effect language service -- whichever the
-- project asked for. Projects without one fall back to the Nix build.
--
-- The native binaries are used directly rather than through `node_modules/.bin`,
-- since those shims need `node` on PATH.
--
-- Evaluated as an expression by `lsp/default.nix`, hence the `return`.
return function(dispatchers, config)
  local platform = "@platform@"
  local fallback = "@fallback@"

  local function file(path)
    local stat = vim.uv.fs_stat(path)
    return stat and stat.type == "file" and path or nil
  end

  local function native(node_modules, pkg, binary)
    local platform_pkg = ("@typescript/%s-%s"):format(pkg, platform)
    local store_pkg = ("@typescript+%s-%s@*"):format(pkg, platform)

    -- npm and yarn hoist the platform package, pnpm and bun keep it in a store.
    for _, pattern in ipairs({
      ("%s/%s"):format(node_modules, platform_pkg),
      ("%s/.pnpm/%s/node_modules/%s"):format(node_modules, store_pkg, platform_pkg),
      ("%s/.bun/%s/node_modules/%s"):format(node_modules, store_pkg, platform_pkg),
    }) do
      for _, dir in ipairs(vim.fn.glob(pattern, true, true)) do
        local exe = file(("%s/lib/%s"):format(dir, binary))
        if exe then
          return exe
        end
      end
    end
  end

  local root = config.root_dir or vim.fn.getcwd()
  local buffer = vim.api.nvim_buf_get_name(0)

  local dirs = vim.fs.find("node_modules", {
    path = buffer ~= "" and vim.fs.dirname(buffer) or root,
    upward = true,
    stop = vim.uv.os_homedir(),
    limit = math.huge,
    type = "directory",
  })

  local cmd = fallback
  for _, node_modules in ipairs(dirs) do
    -- Layouts the globs above miss: the shim resolves the binary itself.
    local exe = native(node_modules, "native-preview", "tsgo")
      or native(node_modules, "typescript", "tsc")
      or file(node_modules .. "/.bin/tsgo")

    if exe then
      cmd = exe
      break
    end
  end

  -- Inspect the pick with `:lua= vim.g.typescript_go_cmd`.
  vim.g.typescript_go_cmd = cmd
  return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers, { cwd = root })
end
