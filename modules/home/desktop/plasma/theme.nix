{
  flake.modules.homeManager.plasma =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (config.catppuccin) flavor accent;
    in
    {
      home.packages = [
        (pkgs.catppuccin-kde.override {
          flavour = [ flavor ];
          accents = [ accent ];
        })
      ];

      programs.plasma.workspace = {
        wallpaper = ../../../../images/wallpaper.png;
        colorScheme = "Catppuccin${lib.toSentenceCase flavor}${lib.toSentenceCase accent}";
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
            variant = flavor;
            accents = [ accent ];
          };
          name = "catppuccin-${flavor}-${accent}-standard";
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

      home.sessionVariablesExtra = ''
        unset XCURSOR_SIZE
      '';
    };
}
