{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    plasma
    mpv
    discord
    ghostty
    bitwarden
    telegram
    qbittorrent
    matrix
    mangohud
  ];
}
