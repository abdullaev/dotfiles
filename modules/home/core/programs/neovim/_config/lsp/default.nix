{
  inputs,
  pkgs,
  lib,
}:
{
  lsp = {
    enable = true;
    formatOnSave = true;

    mappings.toggleFormatOnSave = "\\f";

    servers.typescript-go.cmd = lib.mkForce [
      (lib.getExe inputs.effect-tsgo.packages.${pkgs.stdenv.hostPlatform.system}.effect-tsgo)
    ];

    trouble = {
      enable = true;
      mappings = {
        documentDiagnostics = "<leader>xd";
        lspReferences = "<leader>xr";
        workspaceDiagnostics = "<leader>xw";
      };
      setupOpts = {
        modes = {
          symbols = {
            win = {
              position = "bottom";
            };
          };
        };
        preview = {
          border = false;
        };
      };
    };
  };
}
