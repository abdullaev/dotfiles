{ lib, ... }:
{
  flake.modules.homeManager.stateVersion = {
    home.stateVersion = lib.mkDefault "25.11";
  };
}
