{ root, ... }:
{
  flake.modules.nixos.users =
    {
      config,
      lib,
      pkgs,
      users,
      hostName,
      ...
    }:
    let
      shellPackages = {
        bash = pkgs.bashInteractive;
        inherit (pkgs) fish;
      };
      passwordUsers = lib.filterAttrs (_: user: user.sopsPassword) users;
    in
    {
      users.mutableUsers = false;

      # Decrypted to /run/secrets-for-users BEFORE user creation. Without
      # neededForUsers=true + mutableUsers=false every password is locked.
      # No owner/group: this runs before users exist, must stay root-owned.
      sops.secrets = lib.mapAttrs' (
        name: _:
        lib.nameValuePair "user-passwords/${name}" {
          sopsFile = root + "/secrets/hosts/${hostName}.yaml";
          neededForUsers = true;
        }
      ) passwordUsers;

      users.users = lib.mapAttrs (
        name: user:
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
        // lib.optionalAttrs user.sopsPassword {
          hashedPasswordFile = config.sops.secrets."user-passwords/${name}".path;
        }
      ) users;

      programs.fish.enable = lib.any (user: user.shell == "fish") (lib.attrValues users);
    };
}
