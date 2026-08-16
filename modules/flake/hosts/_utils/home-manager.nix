{ lib, inputs }:
{ config, ... }:
let
  resolveHomeManagerModules = user: config.homeManagerModules ++ user.extraHomeManagerModules;

  enabledHomeManagerUsers = lib.filterAttrs (_: user: user.enableHomeManager) config.users;

  homeManagerUsers = lib.mapAttrs (name: user: {
    _module.args.user = user // {
      inherit name;
    };
    imports = resolveHomeManagerModules user;
  }) enabledHomeManagerUsers;
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
          backupFileExtension = "backup";
          overwriteBackup = true;
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
