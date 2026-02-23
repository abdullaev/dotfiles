{
  flake.modules.homeManager.plasma =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.packages = [
        (pkgs.catppuccin-kde.override {
          flavour = [ "mocha" ];
          accents = [ "lavender" ];
        })
      ];

      programs.plasma = {
        enable = true;

        fonts = {
          general = {
            family = "sans-serif";
            pointSize = 10;
          };
          fixedWidth = {
            family = "monospace";
            pointSize = 10;
          };
          small = {
            family = "sans-serif";
            pointSize = 8;
          };
          toolbar = {
            family = "sans-serif";
            pointSize = 10;
          };
          menu = {
            family = "sans-serif";
            pointSize = 10;
          };
          windowTitle = {
            family = "sans-serif";
            pointSize = 10;
          };
        };

        workspace = {
          wallpaper = config.images.wallpaper;
          colorScheme = "CatppuccinMochaLavender";
          iconTheme = "breeze";
          cursor = {
            theme = "Breeze";
            cursorFeedback = "None";
          };
          splashScreen.theme = "None";
          windowDecorations = {
            library = "org.kde.breeze";
            theme = "Breeze";
          };
        };

        kscreenlocker = {
          appearance = {
            wallpaper = config.images.wallpaper;
          };
        };

        session = {
          sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
        };

        panels = [
          {
            location = "bottom";
            floating = false;
            height = 44;
            widgets = [
              {
                kickoff = {
                  icon = "nix-snowflake";
                  showButtonsFor = {
                    custom = [
                      "lock-screen"
                      "logout"
                      "reboot"
                      "shutdown"
                    ];
                  };
                };
              }
              "org.kde.plasma.pager"
              {
                iconTasks = {
                  appearance = {
                    showTooltips = true;
                    iconSpacing = "medium";
                  };
                  launchers = [
                    "applications:org.kde.dolphin.desktop"
                    "applications:firefox.desktop"
                    "applications:com.mitchellh.ghostty.desktop"
                    "applications:org.telegram.desktop.desktop"
                    "applications:discord.desktop"
                    "applications:steam.desktop"
                  ];
                };
              }
              "org.kde.plasma.marginsseparator"
              "org.kde.plasma.systemtray"
              {
                digitalClock = {
                  date.enable = false;
                };
              }
              "org.kde.plasma.showdesktop"
            ];
          }
        ];

        input.keyboard = {
          repeatDelay = 400;
          repeatRate = 50;
          layouts = [
            { layout = "us"; }
            { layout = "ru"; }
          ];
          options = [ "grp:win_space_toggle" ];
        };

        kwin.nightLight = {
          enable = true;
          mode = "location";
          location = {
            latitude = "55.7558";
            longitude = "37.6176";
          };
          temperature.night = 4000;
        };

        startup.startupScript."ghostty-daemon" = {
          runAlways = true;
          priority = 8;
          text = ''
            ${pkgs.ghostty}/bin/ghostty \
              --gtk-single-instance=true \
              --initial-window=false \
              --quit-after-last-window-closed=false \
              >/dev/null 2>&1 &
          '';
        };
      };

      gtk = {
        enable = true;
        theme = {
          package = pkgs.catppuccin-gtk.override {
            variant = "mocha";
            accents = [ "lavender" ];
          };
          name = "catppuccin-mocha-lavender-standard";
        };
        iconTheme = {
          name = "breeze";
          package = pkgs.kdePackages.breeze-icons;
        };
        cursorTheme = {
          name = "Breeze";
          package = pkgs.kdePackages.breeze;
        };
      };
    };
}
