{ inputs }:
let
  inherit (inputs.nixpkgs) lib;

  hosts = import ../../hosts;
  users = import ../../users;
  profiles = import ../../profiles;

  hostData = import ./hosts-data.nix {
    inherit lib hosts;
    defaultHost = "vega";
  };

  usersLib = import ./users-lib.nix {
    inherit
      lib
      hosts
      users
      profiles
      ;
  };

  nixosData = import ./nixos-data.nix {
    inherit
      inputs
      lib
      hosts
      usersLib
      ;
  };

  checksData = import ./checks-data.nix {
    inherit
      inputs
      lib
      hosts
      hostData
      ;
    inherit (nixosData) nixosConfigurations;
  };
in
{
  systems = hostData.supportedSystems;
  inherit (checksData) checksBySystem;
  inherit (nixosData) nixosConfigurations;
}
