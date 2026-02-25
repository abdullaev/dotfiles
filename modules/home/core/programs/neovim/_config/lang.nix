{ pkgs }:
{
  autocomplete.blink-cmp.enable = true;
  autocomplete.enableSharedCmpSources = true;

  lsp = {
    enable = true;
    formatOnSave = true;
  };

  diagnostics = {
    enable = true;
    config = {
      virtual_text.enable = true;
    };
  };

  treesitter = {
    enable = true;
    grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };

  languages = {
    astro = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      extraDiagnostics.enable = true;
      format.enable = true;
    };
    bash = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
    };
    clang = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      dap.enable = true;
    };
    css = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
    };
    elixir = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
    };
    go = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      dap.enable = true;
    };
    haskell = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    html = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
    };
    json = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
    };
    just = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    lua = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      extraDiagnostics.enable = true;
      format.enable = true;
    };
    markdown = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      extensions.markview-nvim.enable = true;
    };
    nix = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      extraDiagnostics.enable = true;
      format.enable = false;
    };
    ocaml = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
    };
    python = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
    };
    rust = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      dap.enable = true;
    };
    sql = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      extraDiagnostics.enable = true;
      format.enable = true;
    };
    svelte = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      extraDiagnostics.enable = true;
      format.enable = true;
    };
    ts = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
      extraDiagnostics.enable = true;
    };
    typst = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
    };
    yaml = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    zig = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      dap.enable = true;
    };
  };
}
