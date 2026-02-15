{ pkgs, ... }:

{
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    (nerd-fonts.jetbrains-mono)
    (nerd-fonts.symbols-only)
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
        "JetBrains Mono Nerd Font"
        "Symbols Nerd Font Mono"
      ];
    };
  };
}
