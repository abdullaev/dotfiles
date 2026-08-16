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
        (lib.mapAttrs (_: host: host.finalPackage))
      ];
    in
    lib.optionalAttrs (hostPackages != { }) {
      checks.nixos-hosts = pkgs.linkFarm "nixos-hosts-checks" hostPackages;
    };
}
