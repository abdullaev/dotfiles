{
  flake.modules.homeManager.plasma =
    {
      pkgs,
      ...
    }:
    let
      wallpaper = ../../../images/wallpaper.png;
    in
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
          inherit wallpaper;
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

        krunner = {
          position = "center";
        };

        kscreenlocker = {
          appearance = {
            inherit wallpaper;
          };
          autoLock = true;
          timeout = 30;
          passwordRequired = true;
          passwordRequiredDelay = 0;
        };

        session = {
          sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
        };

        powerdevil = {
          AC = {
            powerProfile = "performance";
            autoSuspend.action = "nothing";
            turnOffDisplay = {
              idleTimeout = 1800;
              idleTimeoutWhenLocked = 300;
            };
            dimDisplay.idleTimeout = 900;
          };
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
                    "applications:element-desktop.desktop"
                    "applications:org.qbittorrent.qBittorrent.desktop"
                    "applications:mpv.desktop"
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
          repeatDelay = 300;
          repeatRate = 50;
          layouts = [
            { layout = "us"; }
            { layout = "ru"; }
          ];
          options = [
            "grp:alt_shift_toggle"
            "ctrl:nocaps"
          ];
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
