{
  lib,
  inputs,
  systems,
}:
{
  baseHostModule = import ./base.nix { inherit lib inputs systems; };
  homeManagerModule = import ./home-manager.nix { inherit lib inputs; };
}
