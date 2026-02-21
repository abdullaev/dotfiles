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
          binds.whichKey = {
            enable = true;
            setupOpts = {
              preset = "helix";
            };
          };

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
                    symbols = { added = '+ ', modified = '~ ', removed = '- ' },
                    separator = { left = "", right = "" },
                  }
                ''
              ];
              x = [
                ''
                  {
                    function()
                      local buf_ft = vim.bo.filetype
                      local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

                      if excluded_buf_ft[buf_ft] then
                        return ""
                      end

                      local bufnr = vim.api.nvim_get_current_buf()
                      local clients = vim.lsp.get_clients({ bufnr = bufnr })

                      if vim.tbl_isempty(clients) then
                        return "No Active LSP"
                      end

                      local active_clients = {}
                      for _, client in ipairs(clients) do
                        table.insert(active_clients, client.name)
                      end

                      return table.concat(active_clients, ", ")
                    end,
                    icon = '',
                    separator = { left = "", right = "" },
                  }
                ''
                ''
                  {
                    "diagnostics",
                    sources = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc' },
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
              picker = {
                enabled = true;

                icons = {
                  files = {
                    dir_open = " ";
                  };
                };

                previewers = {
                  diff = {
                    style = "syntax";
                  };
                };
              };
              notifier = {
                enabled = true;
              };
              dashboard = {
                preset = {
                  keys = [
                    {
                      icon = " ";
                      key = "f";
                      desc = "Find File";
                      action = ":lua Snacks.dashboard.pick('files')";
                    }
                    {
                      icon = " ";
                      key = "n";
                      desc = "New File";
                      action = ":ene | startinsert";
                    }
                    {
                      icon = " ";
                      key = "g";
                      desc = "Find Text";
                      action = ":lua Snacks.dashboard.pick('live_grep')";
                    }
                    {
                      icon = " ";
                      key = "r";
                      desc = "Recent Files";
                      action = ":lua Snacks.dashboard.pick('oldfiles')";
                    }
                    {
                      icon = " ";
                      key = "q";
                      desc = "Quit";
                      action = ":qa";
                    }
                  ];
                };
                sections = [
                  {
                    section = "header";
                  }
                  {
                    section = "keys";
                    padding = 1;
                  }
                  {
                    icon = " ";
                    title = "Recent Files";
                    section = "recent_files";
                    indent = 1;
                    padding = 1;
                  }
                  {
                    icon = " ";
                    title = "Projects";
                    section = "projects";
                    indent = 1;
                    padding = 1;
                  }
                ];
              };
            };
          };

          mini = {
            basics = {
              enable = true;
            };
          };

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

          ui.noice = {
            enable = true;
            setupOpts = {
              messages = {
                view_search = "mini";
              };
            };
          };

          visuals.tiny-devicons-auto-colors.enable = true;

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
