{
  flake.modules.homeManager.ghostty =
    { inputs, ... }:
    {
      home.file.".config/ghostty/shaders".source = inputs.ghostty-cursor-shaders;

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

            "U+231A-U+231B,U+23E9-U+23EC,U+23F0,U+23F3,U+25FD-U+25FE,U+2614-U+2615,U+2648-U+2653,U+267F,U+2693,U+26A1,U+26AA-U+26AB,U+26BD-U+26BE,U+26C4-U+26C5,U+26CE,U+26D4,U+26EA,U+26F2-U+26F3,U+26F5,U+26FA,U+26FD,U+2705,U+270A-U+270B,U+2728,U+274C,U+274E,U+2753-U+2755,U+2757,U+2795-U+2797,U+27B0,U+27BF,U+2B1B-U+2B1C,U+2B50,U+2B55=emoji"
            "U+1F004,U+1F0CF,U+1F18E,U+1F191-U+1F19A,U+1F1E6-U+1F1FF,U+1F201,U+1F21A,U+1F22F,U+1F232-U+1F236,U+1F238-U+1F23A,U+1F250-U+1F251,U+1F300-U+1F320,U+1F32D-U+1F335,U+1F337-U+1F37C,U+1F37E-U+1F393,U+1F3A0-U+1F3CA,U+1F3CF-U+1F3D3,U+1F3E0-U+1F3F0,U+1F3F4,U+1F3F8-U+1F43E,U+1F440,U+1F442-U+1F4FC,U+1F4FF-U+1F53D,U+1F54B-U+1F54E,U+1F550-U+1F567,U+1F57A,U+1F595-U+1F596,U+1F5A4,U+1F5FB-U+1F64F,U+1F680-U+1F6C5,U+1F6CC,U+1F6D0-U+1F6D2,U+1F6D5-U+1F6D7,U+1F6DC-U+1F6DF,U+1F6EB-U+1F6EC,U+1F6F4-U+1F6FC,U+1F7E0-U+1F7EB,U+1F7F0,U+1F90C-U+1F93A,U+1F93C-U+1F945,U+1F947-U+1F9FF,U+1FA70-U+1FA7C,U+1FA80-U+1FA89,U+1FA8F-U+1FAC6,U+1FACE-U+1FADC,U+1FADF-U+1FAE9,U+1FAF0-U+1FAF8=emoji"
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
