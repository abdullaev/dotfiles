{
  flake.modules.homeManager.defaults =
    {
      pkgs,
      user,
      ...
    }:
    {
      home = {
        username = user.name;
        homeDirectory = user.homeDirectory;
      };

      programs.git.settings.user = {
        name = user.fullName;
        email = user.email;
      };
    };
}
