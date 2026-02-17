{ config, lib, ... }:
{
  perSystem =
    {
      pkgs,
      system,
      ...
    }:
    let
      hostPackages = lib.pipe config.nixosHosts [
        (lib.filterAttrs (_: host: host.system == system))
        (lib.mapAttrsToList (_: host: host.finalPackage))
      ];
    in
    lib.optionalAttrs (hostPackages != [ ]) {
      checks.nixos-hosts = pkgs.symlinkJoin {
        name = "nixos-hosts-checks";
        paths = hostPackages;
      };
    };
}
