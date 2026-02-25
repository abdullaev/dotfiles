{
  flake.modules.homeManager.bat = _: {
    programs.bat = {
      enable = true;
      config = {
        theme = "Catppuccin Mocha";
      };
    };

    home.shellAliases = {
      cat = "bat";
    };
  };
}
