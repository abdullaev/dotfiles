{ config, lib, ... }:
{
  perSystem =
    {
      pkgs,
      system,
      ...
    }:
    let
      hostPackages = lib.pipe (config.flake.nixosConfigurations or { }) [
        (lib.filterAttrs (_: host: host.pkgs.stdenv.hostPlatform.system == system))
        (lib.mapAttrsToList (_: host: host.config.system.build.toplevel))
      ];
    in
    lib.optionalAttrs (hostPackages != [ ]) {
      checks.nixos-hosts = pkgs.symlinkJoin {
        name = "nixos-hosts-checks";
        paths = hostPackages;
      };
    };
}
