{ pkgs, ... }:

{
  services.desktopManager.plasma6 = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    (catppuccin-gtk.override {
      variant = "mocha";
      accents = [ "lavender" ];
    })
    (catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "lavender" ];
    })
  ];

  programs.steam.package = pkgs.steam.override {
    extraPkgs =
      pkgs: with pkgs; [
        kdePackages.breeze
      ];
  };
}
