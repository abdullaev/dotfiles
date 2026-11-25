{ inputs, pkgs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware-configuration.nix
    ./nuphy-air75-v3.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Release at install time; never bump on upgrades.
  system.stateVersion = "25.11";
}
