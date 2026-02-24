{
  flake.modules.homeManager.bat =
    { pkgs, ... }:
    {
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
