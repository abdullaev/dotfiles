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

            showbreak = "↪";
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

          keymaps = [
            {
              mode = "n";
              key = "<leader>e";
              action = "function() Snacks.explorer() end";
              lua = true;
              desc = "Snacks Explorer";
            }
            {
              mode = "n";
              key = "<leader>ff";
              action = "function() Snacks.picker.files() end";
              lua = true;
              desc = "Find files";
            }
            {
              mode = "n";
              key = "<leader>fg";
              action = "function() Snacks.picker.grep() end";
              lua = true;
              desc = "Live grep";
            }
            {
              mode = "n";
              key = "<leader>fb";
              action = "function() Snacks.picker.buffers() end";
              lua = true;
              desc = "Find buffers";
            }
            {
              mode = "n";
              key = "<leader>fh";
              action = "function() Snacks.picker.help() end";
              lua = true;
              desc = "Help tags";
            }
            {
              mode = "n";
              key = "<leader>gl";
              action = "function() Snacks.picker.git_log() end";
              lua = true;
              desc = "Git commits";
            }
            {
              mode = "n";
              key = "<leader>gL";
              action = "function() Snacks.picker.git_log_line() end";
              lua = true;
              desc = "Git commits (line)";
            }
            {
              mode = "n";
              key = "<leader>gb";
              action = "function() Snacks.picker.git_branches() end";
              lua = true;
              desc = "Git branches";
            }
            {
              mode = "n";
              key = "<leader>gd";
              action = "function() Snacks.picker.git_diff() end";
              lua = true;
              desc = "Git diff hunks";
            }
            {
              mode = "n";
              key = "<leader>gD";
              action = "function() Snacks.picker.git_diff({ staged = true }) end";
              lua = true;
              desc = "Git staged hunks";
            }
            {
              mode = "n";
              key = "<leader>gS";
              action = "function() Snacks.picker.git_stash() end";
              lua = true;
              desc = "Git stash";
            }
            {
              mode = "n";
              key = "<leader>gf";
              action = "function() Snacks.picker.git_log_file() end";
              lua = true;
              desc = "Git commits (file)";
            }
            {
              mode = "n";
              key = "<leader>go";
              action = "function() MiniDiff.toggle_overlay() end";
              lua = true;
              desc = "Git hunk overlay";
            }
          ];

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
                    dir_open = " ";
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
            icons = {
              enable = true;

              setupOpts = {
                directory = {
                  src = {
                    glyph = "󰉋";
                  };
                  lib = {
                    glyph = "󰉋";
                  };
                };
              };
            };
            diff = {
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
            bash = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            clang = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
              dap.enable = true;
            };
            css = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            elixir = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            go = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
              dap.enable = true;
            };
            haskell = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            html = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            json = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            just = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            lua = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            markdown = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
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
            sql = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            svelte = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
              extraDiagnostics.enable = true;
            };
            ts = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
              extraDiagnostics.enable = true;
            };
            yaml = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };
            zig = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
              dap.enable = true;
            };
          };

          ui.noice = {
            enable = true;
            setupOpts = {
              messages = {
                view_search = "mini";
              };
            };
          };

          luaConfigPost = ''
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "debugPC" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })
          '';

          git = {
            enable = true;
            neogit.enable = true;
            git-conflict.enable = true;
            gitsigns.enable = false;
            hunk-nvim.enable = false;
          };
        };
      };
    };
}
