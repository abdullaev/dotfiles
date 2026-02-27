{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      settings = {
        theme = "Catppuccin Mocha";
        adjust-cursor-thickness = 2;
        font-family = "monospace";
        font-codepoint-map = [
          "U+E000-U+F8FF=Symbols Nerd Font"
          "U+F0000-U+FFFFD=Symbols Nerd Font"
          "U+100000-U+10FFFD=Symbols Nerd Font"

          "U+2705=emoji"
        ];
        adjust-icon-height = "-50%";
        font-size = 14;
        app-notifications = false;
        maximize = true;
        window-width = 180;
        window-height = 48;
        click-repeat-interval = 0;

        keybind = [
          "ctrl+shift+z=toggle_split_zoom"
        ];
      };
    };
  };
}
