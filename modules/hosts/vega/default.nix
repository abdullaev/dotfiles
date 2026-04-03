{
  den,
  inputs,
  lib,
  ...
}:
let
  keys = import ../../../shared/keys.nix;
in
{
  den.hosts.x86_64-linux.vega.users.sqxt = {
      fullName = "Amir Abdullaev";
      email = "me@sqxt.dev";
      shell = "fish";
      gpg = {
        enable = true;
        signByDefault = true;
        signingKey = keys.users.sqxt.gpg.signingKey;
      };
      authorizedKeys = [
        keys.users.sqxt.ssh
      ];
      passwordSecret = "sqxt-at-vega";
    };

  den.aspects.vega = {
    includes = with den.aspects; [
      nixosCore
      nixosDesktop
    ];

    nixos.imports = [
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.disko
      ./_nixos
    ];
  };

  den.aspects.sqxt = {
    includes = with den; [
      provides.define-user
      provides.primary-user
      (provides.user-shell "fish")
      aspects.homeCore
      aspects.homeDesktop
      ({ user, ... }:
        let
          homeDirectory = user.homeDirectory or "/home/${user.userName}";
          groups = user.groups or [ ];
          authorizedKeys = user.authorizedKeys or [ ];
          passwordSecret = user.passwordSecret or null;
          linger = user.linger or true;
          fullName = user.fullName or user.userName;
        in
        {
        nixos = { config, ... }: {
          users.users.${user.userName} =
            {
              description = fullName;
              extraGroups = groups;
              home = homeDirectory;
              linger = linger;
            }
            // lib.optionalAttrs (authorizedKeys != [ ]) {
              openssh.authorizedKeys.keys = authorizedKeys;
            }
            // lib.optionalAttrs (passwordSecret != null) {
              hashedPasswordFile = config.age.secrets.${passwordSecret}.path;
            };
        };

        homeManager = {
          home.username = user.userName;
          home.homeDirectory = homeDirectory;
        };
      })
    ];
  };
}
