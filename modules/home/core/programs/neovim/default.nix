{
  flake.modules.homeManager.neovim =
    { pkgs, ... }:
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
            cursorline = true;
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

          visuals.tiny-devicons-auto-colors.enable = true;
          statusline.lualine.enable = true;

          utility.direnv.enable = true;
          utility.nix-develop.enable = true;
          utility.motion.flash-nvim.enable = true;
          utility.smart-splits.enable = true;

          utility.snacks-nvim = {
            enable = true;
            setupOpts = {
              explorer = {
                enabled = true;
                replace_netrw = true;
                trash = true;
              };
              picker.enabled = true;
            };
          };

          ui.fastaction.enable = true;

          lsp = {
            enable = true;
            formatOnSave = true;
          };

          diagnostics = {
            enable = true;
            config = {
              virtual_text.enable = true;
            };
          };

          treesitter = {
            enable = true;

            grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
          };

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
            ts = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
              extraDiagnostics.enable = true;
            };
          };

          debugger.nvim-dap.enable = true;

          luaConfigPost = ''
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "debugPC" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })
            vim.keymap.set("n", "<leader>e", function()
              Snacks.explorer()
            end, { desc = "Snacks Explorer" })
            vim.keymap.set("n", "<leader>ff", function()
              Snacks.picker.files()
            end, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", function()
              Snacks.picker.grep()
            end, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", function()
              Snacks.picker.buffers()
            end, { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fh", function()
              Snacks.picker.help()
            end, { desc = "Help tags" })
            vim.keymap.set("n", "<leader>gs", function()
              Snacks.picker.git_status()
            end, { desc = "Git status" })
            vim.keymap.set("n", "<leader>gl", function()
              Snacks.picker.git_log()
            end, { desc = "Git commits" })
            vim.keymap.set("n", "<leader>gL", function()
              Snacks.picker.git_log_line()
            end, { desc = "Git commits (line)" })
            vim.keymap.set("n", "<leader>gb", function()
              Snacks.picker.git_branches()
            end, { desc = "Git branches" })
            vim.keymap.set("n", "<leader>gd", function()
              Snacks.picker.git_diff()
            end, { desc = "Git diff hunks" })
            vim.keymap.set("n", "<leader>gS", function()
              Snacks.picker.git_stash()
            end, { desc = "Git stash" })
            vim.keymap.set("n", "<leader>gf", function()
              Snacks.picker.git_log_file()
            end, { desc = "Git commits (file)" })
          '';

          mini = {
            basics.enable = true;
            icons.enable = true;
            notify.enable = true;
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
              };
            };
          };
        };
      };
    };
}
