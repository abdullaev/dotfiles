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

      lookAndFeel = "Catppuccin-${lib.toSentenceCase flavor}-${lib.toSentenceCase accent}";
    in
    {
      home.packages = [
        (pkgs.catppuccin-kde.override {
          flavour = [ flavor ];
          accents = [ accent ];
        })
      ];

      programs.plasma = {
        workspace = {
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
        configFile = {
          kdeglobals = {
            General = {
              DeviceLedsAccentColored = true;
            };
            KDE = {
              DefaultLightLookAndFeel = lookAndFeel;
              DefaultDarkLookAndFeel = lookAndFeel;
            };
            "KFileDialog Settings" = {
              "Allow Expansion" = false;
              "Automatically select filename extension" = true;
              "Breadcrumb Navigation" = true;
              "Decoration position" = 2;
              "Show Full Path" = false;
              "Show Inline Previews" = true;
              "Show Preview" = false;
              "Show Speedbar" = true;
              "Show hidden files" = false;
              "Sort by" = "Name";
              "Sort directories first" = true;
              "Sort hidden files last" = false;
              "Sort reversed" = true;
              "Speedbar Width" = 140;
              "View Style" = "DetailTree";
            };
          };
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
