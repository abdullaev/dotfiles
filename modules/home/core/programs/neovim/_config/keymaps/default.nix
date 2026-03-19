{
  keymaps =
    (import ./pickers.nix)
    ++ (import ./git.nix)
    ++ (import ./lsp.nix)
    ++ (import ./terminal.nix)
    ++ (import ./windows.nix);
}
