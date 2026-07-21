{
  flake.modules.nixos.maintenance = {
    services.fstrim.enable = true;
    services.fwupd.enable = true;
    zramSwap.enable = true;
  };
}
