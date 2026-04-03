{
  den.aspects.plasma.nixos = {
      config,
      pkgs,
      ...
    }:
    {
      services.desktopManager.plasma6.enable = true;

      services.displayManager.plasma-login-manager = {
        enable = true;
      };
    };
}
