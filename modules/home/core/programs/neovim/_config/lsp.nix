{
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
}
