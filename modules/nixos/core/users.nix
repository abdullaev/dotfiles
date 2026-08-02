{
  flake.modules.nixos.users =
    {
      config,
      lib,
      pkgs,
      users,
      ...
    }:
    let
      shellPackages = {
        bash = pkgs.bashInteractive;
        inherit (pkgs) zsh fish;
      };
    in
    {
      users.mutableUsers = false;

      users.users = lib.mapAttrs (
        _: user:
        {
          isNormalUser = true;
          description = user.fullName;
          extraGroups = user.groups;
          home = user.homeDirectory;
          inherit (user) linger;
          shell = shellPackages.${user.shell};
        }
        // lib.optionalAttrs (user.authorizedKeys != [ ]) {
          openssh.authorizedKeys.keys = user.authorizedKeys;
        }
        // lib.optionalAttrs (user.passwordSecret != null) {
          hashedPasswordFile = config.age.secrets.${user.passwordSecret}.path;
        }
      ) users;

      programs.zsh.enable = lib.any (user: user.shell == "zsh") (lib.attrValues users);
      programs.fish.enable = lib.any (user: user.shell == "fish") (lib.attrValues users);
    };
}
