{
  flake.modules.nixos.overlays = {
    nixpkgs.overlays = [
      # herdr drops the underline color when it serializes a pane frame for the
      # client, so neovim's diagnostic undercurls come out in the foreground
      # color instead of the severity color. Carry the fix until it lands
      # upstream (still missing on main as of 0.8.0).
      (_: prev: {
        herdr = prev.herdr.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [ ../../../pkgs/herdr/underline-color.patch ];
        });
      })

      # nvf's conform mix preset still references the deprecated `elixir`
      # alias, which spams an eval warning on every rebuild. Resolve the alias
      # to the real package; drop once nvf uses beamPackages.elixir.
      (final: _: {
        elixir = final.beamPackages.elixir;
      })

      # nvim-treesitter's bundled queries are newer than the `diff` grammar
      # nixpkgs pins for them: `queries/diff/highlights.scm` matches on
      # `(change)` (plus the `>`, `<` and `!` tokens), none of which exist in
      # grammar rev 7d20331. Treesitter rejects the whole query, so anything
      # that highlights a diff — snacks pickers previewing a *.patch, neogit —
      # throws `Invalid node type "change"` on every redraw.
      #
      # Bump just that grammar to the rev the queries were written against.
      # Drop once nixpkgs regenerates the nvim-treesitter grammar set.
      (final: prev: {
        vimPlugins = prev.vimPlugins.extend (
          _: prevVim: {
            nvim-treesitter = prevVim.nvim-treesitter.overrideAttrs (old: {
              passthru = old.passthru // {
                allGrammars = map (
                  grammar:
                  if grammar.pname or "" != "tree-sitter-diff" then
                    grammar
                  else
                    grammar.overrideAttrs {
                      version = "0.0.0+rev=1a24d30";
                      src = final.fetchFromGitHub {
                        owner = "tree-sitter-grammars";
                        repo = "tree-sitter-diff";
                        rev = "1a24d30d9b2b0bbf8420e229164462f410fb3ad0";
                        hash = "sha256-GmnHPkdF9MpEyP3CGsGMgiptjemrD5BaU9f6fiGGjJ8=";
                      };
                    }
                ) old.passthru.allGrammars;
              };
            });
          }
        );
      })
    ];
  };
}
