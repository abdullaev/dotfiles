{ ... }:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../../../secrets
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32768;
    }
  ];

  users.mutableUsers = false;
}
