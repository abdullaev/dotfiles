{
  utility.snacks-nvim = {
    enable = true;
    setupOpts = {
      styles = {
        zoom_indicator = {
          text = "󰊓 zoom";
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
      picker = {
        enabled = true;

        sources = {
          explorer = {
            hidden = true;
            layout = {
              layout = {
                position = "right";
              };
            };
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
        debounce = 50;
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
        zoom = {
          show = {
            tabline = false;
          };
        };
      };
    };
  };
}
