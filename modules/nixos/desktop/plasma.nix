{
  flake.modules.nixos.plasma =
    {
      config,
      pkgs,
      ...
    }:
    {
      services.desktopManager.plasma6.enable = true;

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "breeze";
      };

      environment.systemPackages = [
        (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
          [General]
          background = ${config.images.wallpaper}
        '')
      ];
    };
}
