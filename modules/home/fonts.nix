{ pkgs, ... }:

let
  pragmata-pro = pkgs.callPackage ../../pkgs/pragmata-pro { };
in
{
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    pragmata-pro
    (nerd-fonts.iosevka-term)
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      sansSerif = [
        "Noto Sans"
      ];

      serif = [
        "Noto Serif"
      ];

      monospace = [
        "PragmataPro Mono Liga"
        "Iosevka Term Nerd Font Mono"
      ];
    };
  };
}
