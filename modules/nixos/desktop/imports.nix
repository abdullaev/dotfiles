{ den, ... }:
{
  den.aspects.nixosDesktop.includes = [
    den.aspects.de
    den.aspects.nvidia
    den.aspects.bluetooth
    den.aspects.gaming
    den.aspects.keyd
    den.aspects.vpn
    den.aspects.fonts
  ];
}
