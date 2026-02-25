{ pkgs }:
{
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
    autotagHtml = true;
    grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };

  languages = {
    bash = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
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
    };
    elixir = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
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
    };
    json = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
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
    };
    markdown = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    nix = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
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
    };
    svelte = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      extraDiagnostics.enable = true;
    };
    ts = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
      extraDiagnostics.enable = true;
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
