{
  flake.modules.homeManager.opencode = _: {
    programs.opencode = {
      enable = true;
      enableMcpIntegration = true;
    };
  };
}
