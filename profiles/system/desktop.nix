{ ... }:

{
  imports = [
    ../../modules/system/vpn.nix
    ../../modules/system/networking.nix
    ../../modules/system/locale.nix
    ../../modules/system/desktop.nix
    ../../modules/system/fonts.nix
    ../../modules/system/nvidia.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/base.nix
    ../../modules/system/steam.nix
    ../../modules/system/firefox.nix
    ../../modules/system/plasma6.nix
    ../../modules/system/sddm.nix
  ];
}
