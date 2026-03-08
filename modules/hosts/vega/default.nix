{ config, ... }:
let
  keys = import ../../../shared/keys.nix;
in
{
  nixosHosts.vega = {
    system = "x86_64-linux";

    users.sqxt = {
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
      groups = [
        "networkmanager"
        "wheel"
      ];
      extraHomeManagerModules = with config.flake.modules.homeManager; [
        desktop
      ];
    };

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      desktop
    ]);

    homeManagerModules = [
      ./_home
    ]
    ++ (with config.flake.modules.homeManager; [
      core
    ]);
  };
}
