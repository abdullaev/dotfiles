{
  flake.modules.homeManager.fish =
    { user, ... }:
    {
      programs.fish = {
        enable = user.shell == "fish";
      };
    };
}
