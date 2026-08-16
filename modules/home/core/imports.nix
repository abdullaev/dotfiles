{ config, inputs, ... }:
{
  flake.modules.homeManager.core.imports = [
    # Option-providing input modules the core programs below depend on.
    inputs.sops-nix.homeManagerModules.sops
    inputs.nvf.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
  ]
  ++ (with config.flake.modules.homeManager; [
    stateVersion
    sops
    base
    fish
    starship
    git
    gpg
    btop
    bat
    delta
    direnv
    neovim
    fastfetch
    llm
    herdr
    eza
    zoxide
    fzf
    fd
    nh
    ripgrep
    gh
    jq
    cava
    process-compose
  ]);
}
