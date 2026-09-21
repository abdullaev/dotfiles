{ config, inputs, ... }:
{
  flake.modules.homeManager.desktop.imports = [
    # Option-providing input modules the desktop programs below depend on.
    inputs.plasma-manager.homeModules.plasma-manager
  ]
  ++ (with config.flake.modules.homeManager; [
    plasma
    mpv
    godot
    blender
    discord
    ghostty
    telegram
    google-chrome
    qbittorrent
    mangohud
    steam
    firefox
    obsidian
    xdg
  ]);
}
