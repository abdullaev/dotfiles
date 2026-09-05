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
    local package_name = pkg == "typescript" and pkg or "@typescript/" .. pkg
    local dir = vim.uv.fs_realpath(node_modules .. "/" .. package_name)

    -- Resolve from the installed package, following its links into pnpm/bun stores.
    -- Walking Node's lookup locations also supports nested and hoisted npm deps.
    while dir do
      if vim.fs.basename(dir) ~= "node_modules" then
        local exe = file(("%s/node_modules/%s/lib/%s"):format(dir, platform_pkg, binary))
        if exe then
          return exe
        end
      end
      local parent = vim.fs.dirname(dir)
      dir = parent ~= dir and parent or nil
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
    -- Other layouts: the shim resolves the binary itself.
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
