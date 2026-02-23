{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "Catppuccin Mocha";
        adjust-cursor-thickness = 2;
        font-family = "monospace";
        font-size = 13;
        app-notifications = false;
        maximize = true;
        window-width = 200;
        window-height = 48;
        click-repeat-interval = 0;
      };
    };
  };
}
