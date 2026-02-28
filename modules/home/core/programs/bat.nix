{
  flake.modules.homeManager.bat = {
    programs.bat = {
      enable = true;
    };

    catppuccin.bat.enable = true;

    home.shellAliases = {
      cat = "bat";
    };
  };
}
