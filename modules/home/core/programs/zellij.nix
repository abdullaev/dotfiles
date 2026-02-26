{
  flake.modules.homeManager.zellij = {
    programs.zellij = {
      enable = true;
      enableZshIntegration = false;
      settings = {
        theme = "catppuccin-mocha";
        simplified_ui = true;
        pane_frames = false;
        default_layout = "compact";
      };
    };
  };
}
