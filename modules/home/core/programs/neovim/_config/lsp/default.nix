{ pkgs, lib }:
lib.recursiveUpdate {
  lsp = {
    enable = true;
    formatOnSave = true;

    mappings.toggleFormatOnSave = "\\f";

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
} (import ./typescript-go.nix { inherit pkgs lib; })
