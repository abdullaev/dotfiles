{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    mpv
    discord
    ghostty
    bitwarden
    telegram
  ];
}
