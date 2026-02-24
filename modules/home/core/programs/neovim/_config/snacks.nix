{
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
            enabled = false;
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
    };
  };
}
