{
  inputs,
  lib,
  config,
  self,
  ...
}:
let
  inherit (lib)
    types
    mkOption
    ;
  inherit (import ./_utils { inherit lib inputs; }) baseHostModule homeManagerModule;
in
{
  options = {
    nixosHosts =
      let
        hostType = types.submodule [
          baseHostModule
          homeManagerModule
          (
            { name, ... }:
            {
              finalPackage = self.nixosConfigurations.${name}.config.system.build.toplevel;

              modules = [
                inputs.agenix.nixosModules.default
                config.flake.modules.nixos.core
                { networking.hostName = name; }
              ];
            }
          )
        ];
      in
      mkOption {
        type = types.attrsOf hostType;
        default = { };
      };
  };

  config.flake.nixosConfigurations = lib.mapAttrs (
    _: options:
    inputs.nixpkgs.lib.nixosSystem {
      inherit (options)
        system
        modules
        specialArgs
        ;
    }
  ) config.nixosHosts;
}
