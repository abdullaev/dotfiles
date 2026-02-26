{
  flake.modules.homeManager.zellij = {
    programs.zellij = {
      enable = true;
      enableZshIntegration = false;
      enableFishIntegration = false;
      settings = {
        theme = "catppuccin-mocha";
        simplified_ui = true;
        pane_frames = false;
        default_layout = "compact";
      };
    };
  };
}
