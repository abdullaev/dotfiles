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
            path = 0,
            symbols = { modified = '', readonly = '' },
            separator = { left = "", right = "" },
          }
        ''
      ];
      c = [
        ''
          {
            function()
              return require("nvim-navic").get_location({ separator = "  " })
            end,
            cond = function()
              return require("nvim-navic").is_available()
            end,
          }
        ''
      ];
      x = [
        ''
          {
            "diff",
            colored = true,
            symbols = { added = '+', modified = '~', removed = '-' },
            separator = { left = "", right = "" },
          }
        ''
        ''
          {
            "diagnostics",
            symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
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
        ''
          {
            "lsp_status",
            icon = '',
            symbols = {
              spinner = {},
              done = "",
              separator = ', ',
            },
            separator = { left = "", right = "" },
            show_name = true
          }
        ''
      ];
      y = [
        ''
          {
            "branch",
            icon = '',
            separator = { left = "", right = "" },
          }
        ''
      ];
      z = [
        ''
          {
            "location",
            padding = { left = 1, right = 1 },
            separator = { left = "", right = "" }
          }
        ''
        ''
          {
            "progress",
            padding = { left = 0, right = 1 },
            separator = { left = "", right = "" }
          }
        ''
      ];
    };
  };
}
