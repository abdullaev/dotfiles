{
  flake.modules.homeManager.plasma =
    {
      config,
      lib,
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

      programs.plasma.workspace = {
        wallpaper = ../../../../images/wallpaper.png;
        colorScheme = "CatppuccinMochaLavender";
        iconTheme = "breeze";
        cursor = {
          theme = "breeze_cursors";
          size = 24;
          cursorFeedback = "None";
        };
        splashScreen.theme = "None";
        windowDecorations = {
          library = "org.kde.breeze";
          theme = "Breeze";
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
        gtk4.theme = config.gtk.theme;
        iconTheme = {
          name = "breeze";
          package = pkgs.kdePackages.breeze-icons;
        };
      };

      home.file.${config.gtk.gtk2.configLocation}.force = lib.mkForce true;

      home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        name = "breeze_cursors";
        package = pkgs.kdePackages.breeze;
        size = 24;
      };
    };
}
