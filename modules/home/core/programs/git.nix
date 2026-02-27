{
  flake.modules.homeManager.git =
    { user, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
          user = {
            name = user.fullName;
            email = user.email;
          };
        };
      };
    };
}
