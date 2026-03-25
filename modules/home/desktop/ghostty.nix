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
            "U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D7,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6B7,U+E700-U+E8EF,U+EA60-U+EC1E,U+ED00-U+F2FF,U+EE00-U+EE0B,U+F300-U+F381,U+F400-U+F533,U+F0001-U+F1AF0=Symbols Nerd Font"

            "U+2705=emoji"
            "U+274C=emoji"
          ];

          adjust-icon-height = "-55%";
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
