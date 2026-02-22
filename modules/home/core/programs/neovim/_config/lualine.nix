{
  statusline.lualine = {
    enable = true;
    activeSection = {
      a = [
        ''
          {
            "mode",
            icons_enabled = true,
            fmt = function(str) return str:sub(1,1) end,
            separator = { left = "", right = "" },
          }
        ''
      ];
      b = [
        ''
          {
            "filename",
            path = 1,
            symbols = { modified = '', readonly = '' },
            separator = { left = "", right = "" },
          }
        ''
      ];
      c = [
        ''
          {
            "diff",
            colored = true,
            symbols = { added = '+', modified = '~', removed = '-' },
            separator = { left = "", right = "" },
          }
        ''
      ];
      x = [
        ''
          {
            "lsp_status",
            icon = '',
            separator = { left = "", right = "" },
            show_name = true
          }
        ''
        ''
          {
            "diagnostics",
            symbols = { error = '󰅙 ', warn = ' ', info = ' ', hint = '󰌵 ' },
            colored = true,
            update_in_insert = false,
            always_visible = false,
            diagnostics_color = {
              color_error = { fg = 'red' },
              color_warn = { fg = 'yellow' },
              color_info = { fg = 'cyan' },
            },
            separator = { left = "", right = "" },
          }
        ''
      ];
      y = [
        ''
          {
            "branch",
            icon = '',
            separator = { left = "", right = "" },
          }
        ''
      ];
      z = [
        ''
          {
            "progress",
            separator = { left = "", right = "" }
          }
        ''
        ''
          {
            "location",
            separator = { left = "", right = "" }
          }
        ''
        ''
          {
            "fileformat",
            color = { fg = 'black' },
            symbols = {
              unix = '',
              dos = '',
              mac = '',
            },
            separator = { left = "", right = "" }
          }
        ''
      ];
    };
  };
}
