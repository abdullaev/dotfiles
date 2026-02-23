{
  flake.modules.homeManager.plasma =
    { pkgs, ... }:
    {
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
        };

        workspace = {
          wallpaper = ../../../images/wallpaper.png;
          colorScheme = "CatppuccinMochaLavender";
          iconTheme = "breeze";
          cursor.theme = "Breeze";
          splashScreen.theme = "None";
          windowDecorations = {
            library = "org.kde.breeze";
            theme = "Breeze";
          };
        };

        panels = [
          {
            location = "bottom";
            floating = false;
            height = 44;
            widgets = [
              "org.kde.plasma.kickoff"
              "org.kde.plasma.pager"
              "org.kde.plasma.icontasks"
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
      };

      gtk = {
        enable = true;
        theme = {
          package = pkgs.catppuccin-gtk.override {
            variant = "mocha";
            accents = [ "lavender" ];
          };
          name = "catppuccin-mocha-lavender-standard+default";
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
