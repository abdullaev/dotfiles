{
  inputs,
  lib,
  hosts,
  hostData,
  nixosConfigurations,
}:
let
  pkgsBySystem = lib.genAttrs hostData.supportedSystems (
    system: import inputs.nixpkgs { inherit system; }
  );
  defaultPkgs = pkgsBySystem.${hostData.defaultSystem};
  defaultNixosConfig = nixosConfigurations.${hostData.defaultHost};

  mkEvalCheck =
    pkgsForSystem: name: value:
    pkgsForSystem.runCommand name { } ''
      printf '%s\n' "${value}" > "$out"
    '';

  mkHostChecks =
    hostName:
    let
      hostConfig = hosts.${hostName};
      nixosConfig = nixosConfigurations.${hostName};
      hostSystem = hostConfig.system;
      pkgsForSystem = pkgsBySystem.${hostSystem};
      hostUsers = hostConfig.users or [ ];
      homeChecks = lib.listToAttrs (
        map (userName: {
          name = "home-${hostName}-${userName}-activation-eval";
          value =
            mkEvalCheck pkgsForSystem "home-${hostName}-${userName}-activation-eval"
              nixosConfig.config.home-manager.users.${userName}.home.activationPackage.drvPath;
        }) hostUsers
      );
    in
    {
      "${hostSystem}" = {
        "nixos-${hostName}-toplevel-eval" =
          mkEvalCheck pkgsForSystem "nixos-${hostName}-toplevel-eval"
            nixosConfig.config.system.build.toplevel.drvPath;
      }
      // homeChecks;
    };

  generatedChecks = lib.foldl' lib.recursiveUpdate { } (map mkHostChecks hostData.hostNames);
  defaultChecks = {
    "${hostData.defaultSystem}" = {
      nixos-eval = mkEvalCheck defaultPkgs "nixos-eval" defaultNixosConfig.config.system.stateVersion;

      home-eval =
        mkEvalCheck defaultPkgs "home-eval"
          defaultNixosConfig.config.home-manager.users.${hostData.defaultUser}.home.stateVersion;
    };
  };

  checksBySystem = lib.recursiveUpdate generatedChecks defaultChecks;
in
{
  inherit
    checksBySystem
    ;
}
