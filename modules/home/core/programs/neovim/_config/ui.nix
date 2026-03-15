{
  ui = {
    noice = {
      enable = true;
      setupOpts = {
        messages = {
          view_search = false;
        };
        lsp = {
          signature.enabled = false;
          hover.enabled = false;
        };
        popupmenu.enabled = false;
      };
    };

    nvim-ufo = {
      enable = true;
    };

    breadcrumbs = {
      enable = true;
      lualine.winbar.alwaysRender = false;
      lualine.winbar.enable = false;
    };

    borders = {
      enable = true;
    };
  };
}
