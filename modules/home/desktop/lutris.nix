{
  flake.modules.homeManager.lutris =
    { pkgs, ... }:
    {
      programs.lutris = {
        enable = true;
      };
    };
}
