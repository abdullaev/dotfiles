{ pkgs, lib }:
{
  luaConfigRC.haskell-tools-nvim = lib.mkForce ''
    vim.g.haskell_tools = {
      hls = {
        cmd = {
          "${lib.meta.getExe' pkgs.haskellPackages.haskell-language-server "haskell-language-server-wrapper"}",
          "--lsp",
        },
        on_attach = function(_, bufnr, ht)
          local opts = { noremap = true, silent = true, buffer = bufnr }
          local map = function(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
          end

          map('<localleader>cl', vim.lsp.codelens.run, 'Run Haskell code lens')
          map('<localleader>hs', ht.hoogle.hoogle_signature, 'Hoogle search signature')
          map('<localleader>ea', ht.lsp.buf_eval_all, 'Evaluate all snippets')
          map('<localleader>rr', ht.repl.toggle, 'Toggle Haskell REPL')
          map('<localleader>rf', function()
            ht.repl.toggle(vim.api.nvim_buf_get_name(0))
          end, 'Toggle REPL for file')
          map('<localleader>rq', ht.repl.quit, 'Quit Haskell REPL')
        end,
        settings = {
          haskell = {
            formattingProvider = 'ormolu',
            cabalFormattingProvider = 'cabal-fmt',
          },
        },
      },
    }
  '';
}
