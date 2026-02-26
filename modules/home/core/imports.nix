{ config, ... }:
{
  flake.modules.homeManager.core.imports = with config.flake.modules.homeManager; [
    stateVersion
    defaults
    zsh
    zellij
    starship
    git
    btop
    bat
    delta
    direnv
    neovim
    fastfetch
    opencode
    eza
    fonts
    zoxide
    fzf
    fd
    nh
    ripgrep
    gh
  ];
}
