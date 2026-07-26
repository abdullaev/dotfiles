{
  flake.modules.homeManager.google-chrome = {
    programs.google-chrome = {
      enable = true;
      plasmaSupport = true;
    };
  };
}
