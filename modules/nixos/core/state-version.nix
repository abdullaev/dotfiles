{ lib, ... }:
{
  flake.modules.nixos.stateVersion = {
    system.stateVersion = lib.mkDefault "25.11";
  };
}
