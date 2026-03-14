{ pkgs, lib }:
{
  autocomplete = {
    blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts = {
        sources.providers.snippets.opts.filter_snippets = lib.generators.mkLuaInline ''
          function(filetype, file)
            return not (
              filetype ~= "all"
              and file:match("friendly%-snippets/snippets/global%.json$")
            )
          end
        '';
        keymap = {
          preset = "default";
        };
        cmdline = {
          keymap = {
            "<C-y>" = [
              "select_and_accept"
              "fallback"
            ];
          };
        };
        completion = {
          menu = {
            auto_show = true;
            scrollbar = false;
          };
          documentation = {
            auto_show = true;
            window = {
              scrollbar = false;
            };
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
        preview = {
          border = false;
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
    assembly = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
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
    gleam = {
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
    hcl = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
    };
    helm = {
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
      format.enable = true;
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
    odin = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    python = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      format.enable = true;
    };
    qml = {
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
    terraform = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
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
    vala = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    wgsl = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
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
