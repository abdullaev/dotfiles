{ config, ... }:
{
  flake.modules.homeManager.core.imports = with config.flake.modules.homeManager; [
    stateVersion
    base
    zsh
    fish
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
    zoxide
    fzf
    fd
    nh
    ripgrep
    gh
    jq
  ];
}
