{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    plasma
    mpv
    aseprite
    discord
    ghostty
    telegram
    qbittorrent
    matrix
    mangohud
    firefox
  ];
}
