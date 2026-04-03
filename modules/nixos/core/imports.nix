{ den, ... }:
{
  den.aspects.nixosCore.includes = with den.aspects; [
    bootloader
    nix
    networking
    locale
    openssh
  ];
}
