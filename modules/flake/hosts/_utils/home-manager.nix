{ lib, inputs }:
{ config, ... }:
let
  homeManagerUsers = lib.mapAttrs (
    name: user:
    {
      _module.args.user = user // { inherit name; };
      imports = config.homeManagerModules;
    }
  ) config.users;
in
{
  options.homeManagerModules = lib.mkOption {
    type = with lib.types; listOf deferredModule;
    default = [ ];
  };

  config.modules = [
    inputs.home-manager.nixosModules.home-manager
    (
      {
        users,
        hostName,
        ...
      }:
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          sharedModules = [ inputs.nixvim.homeModules.nixvim ];
          backupFileExtension = "backup";
          extraSpecialArgs = {
            inherit
              inputs
              users
              hostName
              ;
          };
          users = homeManagerUsers;
        };
      }
    )
  ];
}
