{ pkgs, lib }:
let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.meta) getExe;

  # conform's builtins already prefer node_modules/.bin via `util.from_node_modules`,
  # so the project's own biome/oxfmt version wins. This only swaps the fallback from
  # a bare PATH lookup to the absolute store path. (prettierd resolves the project's
  # `prettier` itself, relative to the file being formatted.)
  fromNodeModulesOrPackage =
    pkg: bin:
    mkLuaInline ''
      require("conform.util").find_executable({ "node_modules/.bin/${bin}" }, ${builtins.toJSON (getExe pkg)})
    '';

  chain =
    names:
    mkLuaInline "{ ${
      lib.concatMapStringsSep ", " (n: ''"${n}"'') names
    }, stop_after_first = true, lsp_format = \"never\" }";

  full = chain [
    "biome-check"
    "prettierd"
    "oxfmt"
  ];
  fallback = chain [
    "prettierd"
    "oxfmt"
  ];
  partial = chain [
    "prettierd"
    "biome-check"
  ];
in
{
  extraPackages = [
    pkgs.biome
    pkgs.prettierd
    pkgs.oxfmt
  ];

  formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      # nvf enables both save hooks by default and conform registers them as
      # independent autocmds, so every write formats twice: once synchronously on
      # BufWritePre, then again asynchronously on BufWritePost (which calls
      # vim.cmd.update() and can trigger a second write, and so a second lint
      # run). Keep the synchronous one -- it is what guarantees the file that
      # lands on disk is already formatted.
      format_after_save = null;
      # Honor the chains' opt-in policy instead of forcing LSP fallback on save.
      format_on_save = mkLuaInline ''
        function(buf)
          if not vim.g.formatsave or vim.b[buf].disableFormatSave then
            return
          end
          return { bufnr = buf, timeout_ms = 500 }
        end
      '';

      formatters = {
        # `require_cwd` everywhere: if a cloned repo configured no formatter we
        # know about, nothing runs on save, so we never hand its owner a diff
        # full of unrelated reformatting.
        #
        # oxfmt's `cwd` is narrowed rather than inherited: the builtin also
        # matches vite.config.{ts,js} (for viteplus `vite fmt`), which would make
        # oxfmt fire in essentially every Vite project. These three are exactly
        # what oxfmt itself auto-discovers.
        oxfmt = {
          command = fromNodeModulesOrPackage pkgs.oxfmt "oxfmt";
          require_cwd = true;
          cwd = mkLuaInline ''
            require("conform.util").root_file({
              ".oxfmtrc.json",
              ".oxfmtrc.jsonc",
              "oxfmt.config.ts",
            })
          '';
        };

        "biome-check" = {
          command = fromNodeModulesOrPackage pkgs.biome "biome";
          require_cwd = true;
        };

        prettierd = {
          command = fromNodeModulesOrPackage pkgs.prettierd "prettierd";
          require_cwd = true;
        };
      };

      formatters_by_ft = {
        javascript = full;
        javascriptreact = full;
        typescript = full;
        typescriptreact = full;

        json = full;
        jsonc = full;
        css = full;
        graphql = full;

        # biome formats only the <script> block, so stop_after_first would end
        # the chain before the template is ever touched. oxfmt handles both.
        vue = fallback;

        # biome supports plain CSS only.
        scss = fallback;
        less = fallback;

        # biome's HTML formatter is disabled by default and returns the buffer
        # unchanged with exit 0, silently swallowing the rest of the chain.
        html = fallback;

        # biome has no yaml/markdown handler at all.
        yaml = fallback;
        markdown = fallback;
        mdx = fallback;

        # oxfmt silently no-ops on .svelte and rejects .astro outright; biome
        # last is a partial (script/frontmatter-only) fallback.
        svelte = partial;
        astro = partial;

        # Neither biome nor prettier formats TOML.
        toml = chain [ "oxfmt" ];
      };
    };
  };
}
