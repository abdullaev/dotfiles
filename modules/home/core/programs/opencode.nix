{
  flake.modules.homeManager.opencode = {
    programs.opencode = {
      enable = true;
      enableMcpIntegration = true;
    };

    catppuccin.opencode.enable = true;
  };
}
