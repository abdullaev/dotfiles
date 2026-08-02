{
  flake.modules.nixos.bootloader = { pkgs, ... }: {
    boot.loader.systemd-boot.enable = true;
    # The ESP is 1G; without a cap a burst of rebuilds inside the 14d gc window
    # can fill it and break nixos-rebuild partway through.
    boot.loader.systemd-boot.configurationLimit = 20;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_zen;
  };
}
