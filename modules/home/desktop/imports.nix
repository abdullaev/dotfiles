{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    plasma
    mpv
    aseprite
    discord
    ghostty
    telegram
    google-chrome
    qbittorrent
    mangohud
    firefox
    pob
  ];
}
