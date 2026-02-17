{
  flake.modules.homeManager.nh =
    { user, ... }:
    {
      programs.nh = {
        enable = true;
        flake = user.dotfilesPath;
      };
    };
}
