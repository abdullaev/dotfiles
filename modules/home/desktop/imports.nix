{ config, inputs, ... }:
{
  flake.modules.homeManager.desktop.imports = [
    # Option-providing input modules the desktop programs below depend on.
    inputs.plasma-manager.homeModules.plasma-manager
    inputs.curseforge.homeManagerModules.default
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
    lutris
    curseforge
    firefox
    obsidian
    xdg
  ]);
}
