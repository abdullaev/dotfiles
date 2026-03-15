{
  flake.modules.homeManager.cava = {
    programs.cava = {
      enable = true;
      settings = {
        general.framerate = 240;
      };
    };

    catppuccin.cava.enable = true;
  };
}
