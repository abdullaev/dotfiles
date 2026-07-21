{
  flake.modules.homeManager.eza = {
    programs.eza = {
      enable = true;
      icons = "always";
    };

    catppuccin.eza.enable = true;
  };
}
