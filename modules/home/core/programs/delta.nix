{
  flake.modules.homeManager.delta = {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
        navigate = true;
        side-by-side = true;
      };
    };

    catppuccin.delta.enable = true;
  };
}
