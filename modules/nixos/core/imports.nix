{ config, ... }:
{
  flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
    stateVersion
    bootloader
    nix
    networking
    locale
    openssh
  ];
}
