{
  flake.modules.homeManager.ghostty =
    { pkgs, ... }:
    {
      home.file.".config/ghostty/shaders".source = pkgs.fetchFromGitHub {
        owner = "sahaj-b";
        repo = "ghostty-cursor-shaders";
        rev = "4faa83e4b9306750fc8de64b38c6f53c57862db8";
        hash = "sha256-ruhEqXnWRCYdX5mRczpY3rj1DTdxyY3BoN9pdlDOKrE=";
      };

      programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
        settings = {
          window-width = 180;
          window-height = 48;
          window-padding-x = 0;
          window-padding-y = 0;
          window-padding-balance = true;

          window-inherit-working-directory = false;
          tab-inherit-working-directory = true;
          split-inherit-working-directory = true;

          font-family = "monospace";
          font-size = 14;
          font-codepoint-map = [
            "U+E000-U+F8FF=Symbols Nerd Font"
            "U+F0000-U+FFFFD=Symbols Nerd Font"
            "U+100000-U+10FFFD=Symbols Nerd Font"

            "U+2705=emoji"
            "U+274C=emoji"
          ];

          adjust-icon-height = "-50%";
          adjust-cursor-thickness = 2;

          click-repeat-interval = 0;
          app-notifications = false;

          custom-shader-animation = "always";
          custom-shader = [
            "shaders/cursor_warp.glsl"
            "shaders/ripple_cursor.glsl"
          ];

          keybind = [ ];
        };
      };

      catppuccin.ghostty.enable = true;
    };
}
