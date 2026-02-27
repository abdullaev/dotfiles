{ config, ... }:
{
  flake.modules.nixos.desktop.imports = with config.flake.modules.nixos; [
    de
    nvidia
    bluetooth
    steam
    firefox
    plasma
    vpn
    fonts
  ];
}
