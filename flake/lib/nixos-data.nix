{
  inputs,
  lib,
  hosts,
  usersLib,
}:
let
  mkNixosConfiguration =
    hostName: hostConfig:
    let
      hostUsers = hostConfig.users or [ ];
      userSystemModules = usersLib.mkUserSystemModules hostName hostUsers;
      homeUsers = usersLib.mkHomeUsers hostName hostUsers;
      homeManagerModule = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          sharedModules = [ inputs.nixvim.homeModules.nixvim ];
          users = homeUsers;
          backupFileExtension = "backup";
        };
      };
    in
    lib.nixosSystem {
      system = hostConfig.system;
      modules = [
        inputs.agenix.nixosModules.default
        ../../system.nix
        ../../secrets
        {
          networking.hostName = hostName;
        }
      ]
      ++ (hostConfig.modules or [ ])
      ++ userSystemModules
      ++ [
        inputs.home-manager.nixosModules.home-manager
        homeManagerModule
      ];
    };

  nixosConfigurations = lib.mapAttrs mkNixosConfiguration hosts;
in
{
  inherit
    nixosConfigurations
    ;
}
