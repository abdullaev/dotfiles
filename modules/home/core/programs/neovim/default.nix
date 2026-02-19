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

          options = {
            scrolloff = 8;
            tabstop = 2;
            shiftwidth = 2;
          };

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
          };

          undoFile.enable = true;

          clipboard = {
            enable = true;
            providers.wl-copy.enable = true;
            registers = "unnamedplus";
          };

          lazy.enable = true;
          autocomplete.blink-cmp.enable = true;
          binds.whichKey.enable = true;

          visuals.nvim-web-devicons.enable = true;
          visuals.tiny-devicons-auto-colors.enable = true;
          statusline.lualine.enable = true;
          telescope.enable = true;

          utility.direnv.enable = true;
          utility.nix-develop.enable = true;
          utility.motion.flash-nvim.enable = true;
          utility.smart-splits.enable = true;

          ui.fastaction.enable = true;

          lsp = {
            enable = true;
            formatOnSave = true;
          };

          diagnostics = {
            enable = true;
            nvim-lint.enable = true;
            config = {
              virtual_text.enable = true;
            };
          };

          treesitter.enable = true;

          languages = {
            nix = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            rust = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
              dap.enable = true;
            };
          };

          debugger.nvim-dap.enable = true;

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
              };
            };
          };
        };
      };
    };
}
