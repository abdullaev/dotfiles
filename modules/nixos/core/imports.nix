{ config, ... }:
{
  flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
    stateVersion
    overlays
    bootloader
    nix
    nixLd
    networking
    locale
    location
    openssh
    maintenance
    users
  ];
}
