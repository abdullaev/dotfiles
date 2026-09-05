{ lib }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  statusline.lualine = {
    enable = true;

    integrations.breadcrumbs.nvim-navic.enable = true;

    setupOpts = {
      options = {
        section_separators = {
          left = "";
          right = "";
        };
        component_separators = {
          left = "";
          right = "";
        };
      };

      sections = {
        lualine_a = [
          (mkLuaInline ''
            {
              "mode",
              icons_enabled = true,
              fmt = function(str) return str:sub(1,1) end,
            }
          '')
        ];
        lualine_b = [
          (mkLuaInline ''
            {
              "filename",
              path = 0,
              symbols = { modified = '', readonly = '' },
            }
          '')
        ];
        lualine_c = lib.mkForce [
          (mkLuaInline ''
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
        lualine_x = [
          (mkLuaInline ''
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
          '')
          (mkLuaInline ''
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
          '')
        ];
        lualine_y = [
          (mkLuaInline ''
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
          '')
          (mkLuaInline ''
            {
              "branch",
              icon = '',
            }
          '')
        ];
        lualine_z = [
          (mkLuaInline ''
            {
              "location",
              padding = { left = 1, right = 1 },
            }
          '')
          (mkLuaInline ''
            {
              "progress",
              padding = { left = 0, right = 1 },
            }
          '')
          (mkLuaInline ''
            {
              "searchcount",
              padding = { left = 0, right = 0 },
            }
          '')
        ];
      };
    };
  };
}
