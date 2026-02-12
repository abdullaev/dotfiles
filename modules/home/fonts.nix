{ pkgs, ... }:

let
  pragmata-pro = pkgs.callPackage ../../pkgs/pragmata-pro { };
in

{
  home.packages = with pkgs; [
    pragmata-pro
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    (nerd-fonts.jetbrains-mono)
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
        "JetBrainsMono Nerd Font"
      ];
    };
  };
}
