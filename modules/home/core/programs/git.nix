{
  den.aspects.git = { user, ... }:
    let
      gpg = user.gpg or { };
      gpgEnable = gpg.enable or false;
      signingKey = gpg.signingKey or null;
      signByDefault = gpg.signByDefault or false;
      fullName = user.fullName or user.userName;
      email = user.email or "";
    in
    {
      homeManager = { lib, ... }:
        {
          programs.git = {
            enable = true;
            signing = lib.mkIf gpgEnable {
              format = "openpgp";
              key = signingKey;
              signByDefault = signByDefault && signingKey != null;
            };
            settings = {
              init.defaultBranch = "main";
              user = {
                name = fullName;
                email = email;
              };
              diff.tool = "vimdiff";
              rerere.enabled = true;
              merge.conflictStyle = "zdiff3";
            };
          };
        };
    };
}
