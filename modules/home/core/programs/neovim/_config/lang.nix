{ pkgs }:
{
  autocomplete = {
    blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts = {
        completion = {
          menu = {
            enabled = true;
            scrollbar = false;
          };
          documentation = {
            enabled = true;
            window = {
              scrollbar = false;
            };
          };
          signature = {
            enabled = true;
            window = {
              scrollbar = false;
            };
          };
        };
      };
      mappings = {
        next = "<C-n>";
        previous = "<C-p>";
        scrollDocsDown = "<C-f>";
        scrollDocsUp = "<C-b>";
      };
    };
  };

  lsp = {
    enable = true;
    formatOnSave = true;

    mappings.toggleFormatOnSave = "\\f";

    trouble = {
      enable = true;
      setupOpts = {
        modes = {
          symbols = {
            win = {
              position = "left";
              size = 0.25;
            };
          };
        };
      };
    };
  };

  diagnostics = {
    enable = true;
    config = {
      # virtual_text.enable = true;
      # virtual_lines.enable = true;
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
      format.enable = true;
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
      extraDiagnostics.enable = true;
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
