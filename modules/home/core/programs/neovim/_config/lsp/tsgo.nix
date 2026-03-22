{ pkgs, lib }:
let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.meta) getExe;
  inherit (lib) mkForce;
in
{
  extraPackages = [
    pkgs.typescript-go
  ];

  lsp.servers.tsgo = {
    cmd = mkForce (mkLuaInline ''
      function(dispatchers, config)
        local cmd = ${builtins.toJSON (getExe pkgs.typescript-go)}
        local root_dir = (config or {}).root_dir
        local local_cmd = root_dir and (root_dir .. "/node_modules/.bin/tsgo")

        if local_cmd and vim.fn.executable(local_cmd) == 1 then
          cmd = local_cmd
        end

        return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
      end
    '');
  };
}
