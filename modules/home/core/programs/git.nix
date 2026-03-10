{
  flake.modules.homeManager.git =
    { lib, user, ... }:
    {
      programs.git = {
        enable = true;
        signing = lib.mkIf user.gpg.enable {
          format = "openpgp";
          key = user.gpg.signingKey;
          signByDefault = user.gpg.signByDefault && user.gpg.signingKey != null;
        };
        settings = {
          init.defaultBranch = "main";
          user = {
            name = user.fullName;
            email = user.email;
          };
          diff.tool = "vimdiff";
        };
      };
    };
}
