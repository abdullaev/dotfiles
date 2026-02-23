{ config, ... }:
{
  flake.modules.nixos.desktop.imports = with config.flake.modules.nixos; [
    desktopBase
    nvidia
    bluetooth
    steam
    firefox
    plasma
    vpn
  ];
}
