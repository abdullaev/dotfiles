{ lib }:
{
  statusline.lualine = {
    enable = true;

    integrations.breadcrumbs.nvim-navic.enable = true;
    setupOpts.sections.lualine_c = lib.mkForce [
      (lib.generators.mkLuaInline ''
        {
          function()
            return require("nvim-navic").get_location({ separator = "  " })
          end,
          cond = function()
            return require("nvim-navic").is_available()
          end,
        }
      '')
    ];

    sectionSeparator = {
      left = "";
      right = "";
    };
    componentSeparator = {
      left = "";
      right = "";
    };

    activeSection = {
      a = [
        ''
          {
            "mode",
            icons_enabled = true,
            fmt = function(str) return str:sub(1,1) end,
          }
        ''
      ];
      b = [
        ''
          {
            "filename",
            path = 0,
            symbols = { modified = '', readonly = '' },
          }
        ''
      ];
      x = [
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
            padding = { left = 1, right = 0 },
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
            show_name = true
          }
        ''
      ];
      y = [
        ''
          {
            "diff",
            colored = true,
            symbols = { added = '+', modified = '~', removed = '-' },
            source = function()
              local summary = vim.b.minidiff_summary
              return summary and {
                added = summary.add,
                modified = summary.change,
                removed = summary.delete,
              }
            end,
            padding = { left = 1, right = 0 },
          }
        ''
        ''
          {
            "branch",
            icon = '',
          }
        ''
      ];
      z = [
        ''
          {
            "location",
            padding = { left = 1, right = 1 },
          }
        ''
        ''
          {
            "progress",
            padding = { left = 0, right = 1 },
          }
        ''
        ''
          {
            "searchcount",
            padding = { left = 0, right = 0 },
          }
        ''
      ];
    };
  };
}
