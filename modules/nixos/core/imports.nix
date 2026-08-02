{ config, ... }:
{
  flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
    stateVersion
    overlays
    bootloader
    nix
    networking
    locale
    location
    openssh
    maintenance
    users
  ];
}
