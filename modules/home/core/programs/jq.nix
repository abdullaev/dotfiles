{
  flake.modules.homeManager.jq = _: {
    programs.jq = {
      enable = true;
    };
  };
}
