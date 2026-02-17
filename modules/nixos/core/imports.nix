{ config, ... }:
{
  flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
    stateVersion
    bootloader
    nix
    packages
    networking
    locale
    openssh
  ];
}
