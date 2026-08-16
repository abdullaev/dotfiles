{ config, ... }:
{
  flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
    overlays
    bootloader
    sops
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
