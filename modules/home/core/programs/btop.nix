{
  flake.modules.homeManager.btop = {
    programs.btop = {
      enable = true;
    };

    catppuccin.btop.enable = true;
  };
}
