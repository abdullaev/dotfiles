{
  keymaps =
    (import ./keymaps/pickers.nix)
    ++ (import ./keymaps/git.nix)
    ++ (import ./keymaps/lsp.nix)
    ++ (import ./keymaps/terminal.nix)
    ++ (import ./keymaps/sidekick.nix)
    ++ (import ./keymaps/windows.nix)
    ++ (import ./keymaps/misc.nix);
}
