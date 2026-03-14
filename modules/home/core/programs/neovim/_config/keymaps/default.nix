{
  keymaps =
    (import ./pickers.nix)
    ++ (import ./git.nix)
    ++ (import ./lsp.nix)
    ++ (import ./terminal.nix)
    ++ (import ./sidekick.nix)
    ++ (import ./windows.nix)
    ++ (import ./edit.nix);
}
