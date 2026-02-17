{
  flake.modules.homeManager.eza = {
    programs.eza.enable = true;

    home.shellAliases = {
      ls = "eza --icons=always";
      ll = "eza --icons=always -l";
      la = "eza --icons=always -la";
      tree = "eza --icons=always --tree";
    };
  };
}
