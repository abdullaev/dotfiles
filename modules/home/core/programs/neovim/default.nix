{
  flake.modules.homeManager.neovim =
    { ... }:
    {
      programs.nvf = {
        enable = true;
        defaultEditor = true;
        settings.vim = {
          viAlias = true;
          vimAlias = true;

          globals = {
            mapleader = " ";
            maplocalleader = " ";
          };

          options = {
            number = true;
            relativenumber = true;
            termguicolors = true;
            mouse = "a";
            clipboard = "unnamedplus";
            breakindent = true;
            undofile = true;
            ignorecase = true;
            smartcase = true;
            signcolumn = "yes";
            updatetime = 250;
            timeoutlen = 300;
            splitright = true;
            splitbelow = true;
            cursorline = true;
            scrolloff = 8;
            tabstop = 2;
            shiftwidth = 2;
            expandtab = true;
            smartindent = true;
          };

          ui.colorizer.enable = true;

          lazy.enable = true;

          autocomplete.blink-cmp.enable = true;

          visuals.nvim-web-devicons.enable = true;

          binds.whichKey.enable = true;

          visuals.tiny-devicons-auto-colors.enable = true;

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
          };

          statusline.lualine = {
            enable = true;
            theme = "catppuccin";

            sectionSeparator = {
              left = "";
              right = "";
            };

            componentSeparator = {
              left = "⁞";
              right = "";
            };

            setupOpts.sections = {
              lualine_a = [ "mode" ];
              lualine_b = [
                "branch"
                "diff"
                "diagnostics"
              ];
              lualine_c = [
                [
                  "filename"
                  {
                    _type = "lua-inline";
                    expr = "path = 1";
                  }
                ]
              ];
              lualine_x = [ "lsp_status" ];
              lualine_y = [ "progress" ];
              lualine_z = [ "location" ];
            };
          };

          telescope = {
            enable = true;
          };

          lsp = {
            enable = true;
            formatOnSave = true;
          };

          diagnostics = {
            enable = true;
          };

          treesitter = {
            enable = true;
            highlight.enable = true;
            indent.enable = true;
          };

          languages = {
            nix = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
          };

          git = {
            enable = true;
            gitsigns = {
              enable = true;
              setupOpts = {
                signs = {
                  add.text = "▌";
                  change.text = "▌";
                  delete.text = "▌";
                  topdelete.text = "▌";
                  changedelete.text = "▌";
                  untracked.text = "▌";
                };
                signs_staged = {
                  add.text = "▌";
                  change.text = "▌";
                  delete.text = "▌";
                  topdelete.text = "▌";
                  changedelete.text = "▌";
                  untracked.text = "▌";
                };
                signs_staged_enable = true;
                signcolumn = true;
                numhl = false;
                linehl = false;
                current_line_blame = false;
              };
            };
          };
        };
      };
    };
}
