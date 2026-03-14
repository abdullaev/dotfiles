{
  lsp = {
    enable = true;
    formatOnSave = true;

    mappings.toggleFormatOnSave = "\\f";

    trouble = {
      enable = true;
      setupOpts = {
        modes = {
          symbols = {
            win = {
              position = "left";
              size = 0.25;
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
