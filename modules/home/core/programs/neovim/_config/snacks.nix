{ pkgs, lib }:
{
  utility.snacks-nvim = {
    enable = true;
    setupOpts = {
      styles = {
        zoom_indicator = {
          text = "󰊓";
        };
      };

      bigfile = {
        enabled = true;
      };
      quickfile = {
        enabled = true;
      };
      input = {
        enabled = true;
      };
      image = {
        enabled = false;
      };
      terminal = {
        enabled = true;
      };
      notifier = {
        enabled = true;
      };
      explorer = {
        enabled = true;
        replace_netrw = true;
        trash = true;
      };
      indent = {
        enabled = true;
        animate = {
          enabled = false;
        };
        indent = {
          enabled = false;
        };
        scope = {
          enabled = false;
        };
        chunk = {
          enabled = true;
          char = {
            corner_top = "╭";
            corner_bottom = "╰";
            arrow = "─";
          };
        };
      };
      picker = {
        enabled = true;

        db = {
          sqlite3_path = "${pkgs.sqlite.out}/lib/libsqlite3.so";
        };

        sources = {
          explorer = {
            hidden = true;
            ignored = true;
            auto_close = true;
            jump = {
              close = true;
            };
            layout = {
              preset = "vertical";
            };
          };

          projects = {
            dev = [ "~" ];
            patterns = [
              ".obsidian"
              ".git"
              "_darcs"
              ".hg"
              ".bzr"
              ".svn"
              "package.json"
              "Makefile"
            ];
          };
        };

        previewers = {
          diff = {
            style = "fancy";
          };
        };

        icons = {
          git = {
            staged = "";
            added = "";
            deleted = "󰚃";
            ignored = "";
            modified = "";
            untracked = "";
          };
          diagnostics = {
            Error = " ";
            Warn = " ";
            Hint = "󰌵 ";
            Info = " ";
          };
        };
      };
      words = {
        debounce = 25;
        notify_jump = false;
        notify_end = true;
        foldopen = true;
        jumplist = true;
        modes = [
          "n"
          "i"
          "c"
        ];
      };
      dashboard = {
        preset = {
          keys = [
            {
              key = "f";
              desc = "Find File";
              action = ":lua Snacks.dashboard.pick('files')";
            }
            {
              key = "n";
              desc = "New File";
              action = ":ene | startinsert";
            }
            {
              key = "g";
              desc = "Find Text";
              action = ":lua Snacks.dashboard.pick('live_grep')";
            }
            {
              key = "r";
              desc = "Recent Files";
              action = ":lua Snacks.dashboard.pick('oldfiles')";
            }
            {
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
            title = "Recent Files";
            section = "recent_files";
            indent = 1;
            padding = 1;
          }
          {
            title = "Projects";
            section = "projects";
            indent = 1;
            padding = 1;
          }
        ];
      };
      zen = {
        toggles = {
          dim = false;
          git_signs = true;
          mini_diff_signs = true;
          diagnostics = true;
        };
        zoom = {
          show = {
            tabline = false;
          };
        };
      };
    };
  };
}
