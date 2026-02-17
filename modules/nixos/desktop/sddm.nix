{
  flake.modules.nixos.sddm =
    { pkgs, lib, ... }:
    let
      wallpaper = ../../../images/wallpaper.png;
    in
    {
      services.displayManager.sddm = {
        enable = lib.mkDefault true;
        wayland.enable = true;
        theme = "breeze";
      };

      environment.systemPackages = [
        (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
          [General]
          background = ${wallpaper}
        '')
      ];
    };
}
