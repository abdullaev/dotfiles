{
  flake.modules.homeManager.mpv = {
    programs.mpv = {
      enable = true;
    };

    catppuccin.mpv.enable = true;
  };
}
