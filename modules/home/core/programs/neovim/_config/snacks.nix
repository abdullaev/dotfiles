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
}
