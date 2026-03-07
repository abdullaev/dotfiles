{ lib, inputs }:
{ config, ... }:
let
  resolveHomeManagerModules =
    user:
    (if user.homeManagerModules == null then config.homeManagerModules else user.homeManagerModules)
    ++ user.extraHomeManagerModules;

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
          sharedModules = [
            inputs.nvf.homeManagerModules.default
            inputs.plasma-manager.homeModules.plasma-manager
            inputs.catppuccin.homeModules.catppuccin
          ];
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
