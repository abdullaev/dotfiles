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

      cursorName = "breeze_cursors";
      cursorSize = 24;
    in
    {
      home.packages = [
        (pkgs.catppuccin-kde.override {
          flavour = [ flavor ];
          accents = [ accent ];
        })
      ];

      programs.plasma.workspace = {
        wallpaper = builtins.path {
          name = "wallpaper.png";
          path = ../../../../images/wallpaper.png;
        };
        colorScheme = "Catppuccin${lib.toSentenceCase flavor}${lib.toSentenceCase accent}";
        iconTheme = "breeze";
        cursor = {
          theme = cursorName;
          size = cursorSize;
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
        name = cursorName;
        package = pkgs.kdePackages.breeze;
        size = cursorSize;
      };

      # home.pointerCursor exports XCURSOR_SIZE, which overrides Plasma's
      # per-screen cursor scaling; unset it and let kcminputrc win.
      home.sessionVariablesExtra = ''
        unset XCURSOR_SIZE
      '';
    };
}
