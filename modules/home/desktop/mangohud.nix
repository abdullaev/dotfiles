{
  flake.modules.homeManager.mangohud = {
    programs.mangohud = {
      enable = true;
    };

    catppuccin.mangohud.enable = true;
  };
}
