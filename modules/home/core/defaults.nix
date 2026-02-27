{
  flake.modules.homeManager.defaults =
    {
      user,
      ...
    }:
    {
      home = {
        username = user.name;
        homeDirectory = user.homeDirectory;
      };
    };
}
