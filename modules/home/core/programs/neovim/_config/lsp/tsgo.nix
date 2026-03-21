{ pkgs, lib }:
let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.meta) getExe;
in
{
  extraPackages = [
    pkgs.typescript-go
  ];

  lsp.servers.tsgo = {
    cmd = mkLuaInline ''
      function(dispatchers, config)
        local cmd = ${builtins.toJSON (getExe pkgs.typescript-go)}
        local root_dir = (config or {}).root_dir
        local local_cmd = root_dir and (root_dir .. "/node_modules/.bin/tsgo")

        if local_cmd and vim.fn.executable(local_cmd) == 1 then
          cmd = local_cmd
        end

        return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
      end
    '';

    filetypes = [
      "javascript"
      "javascriptreact"
      "typescript"
      "typescriptreact"
    ];

    root_dir = mkLuaInline ''
      function(bufnr, on_dir)
        local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
        root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
          or vim.list_extend(root_markers, { ".git" })

        local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
        local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
        local project_root = vim.fs.root(bufnr, root_markers)

        if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
          return
        end

        if deno_root and (not project_root or #deno_root >= #project_root) then
          return
        end

        on_dir(project_root or vim.fn.getcwd())
      end
    '';

    settings = {
      typescript.inlayHints = {
        parameterNames = {
          enabled = "literals";
          suppressWhenArgumentMatchesName = true;
        };
        parameterTypes.enabled = true;
        variableTypes.enabled = true;
        propertyDeclarationTypes.enabled = true;
        functionLikeReturnTypes.enabled = true;
        enumMemberValues.enabled = true;
      };
    };

    on_attach = mkLuaInline ''
      function(client, bufnr)
        local code_action_provider = client.server_capabilities.codeActionProvider
        local code_action_kinds = type(code_action_provider) == "table" and code_action_provider.codeActionKinds or nil

        if not code_action_kinds then
          return
        end

        vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
          local source_actions = vim.tbl_filter(function(action)
            return vim.startswith(action, "source.")
          end, code_action_kinds)

          if vim.tbl_isempty(source_actions) then
            return
          end

          vim.lsp.buf.code_action({
            context = {
              only = source_actions,
            },
          })
        end, {
          desc = "Run TypeScript source code actions",
        })
      end
    '';
  };
}
