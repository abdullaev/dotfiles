{ pkgs, lib }:
{
  extraPackages = [
    pkgs.biome
    pkgs.prettierd
    pkgs.oxfmt
  ];

  formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      formatters = {
        oxfmt = {
          command = lib.meta.getExe pkgs.oxfmt;
          args = [
            "--stdin-filepath"
            "$FILENAME"
          ];
          stdin = true;
          cwd = lib.generators.mkLuaInline ''
            require("conform.util").root_file({
              ".oxfmtrc.json",
              ".oxfmtrc.jsonc",
              "oxfmt.config.ts",
            })
          '';
        };

        biome = {
          command = lib.meta.getExe pkgs.biome;
          args = [
            "check"
            "--write"
            "--formatter-enabled=true"
            "--linter-enabled=false"
            "--assist-enabled=true"
            "--stdin-file-path"
            "$FILENAME"
          ];
          stdin = true;
          require_cwd = true;
          cwd = lib.generators.mkLuaInline ''
            require("conform.util").root_file({
              "biome.json",
              "biome.jsonc",
              ".biome.json",
              ".biome.jsonc",
            })
          '';
        };

        prettierd = {
          command = lib.meta.getExe pkgs.prettierd;
          args = [
            "--stdin"
            "--stdin-filepath"
            "$FILENAME"
          ];
          stdin = true;
          require_cwd = true;
          cwd = lib.generators.mkLuaInline ''
            require("conform.util").root_file({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.json5",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              ".prettierrc.ts",
              ".prettierrc.toml",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
              "prettier.config.ts",
            })
          '';
        };
      };

      formatters_by_ft = {
        javascript = lib.generators.mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        javascriptreact = lib.generators.mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        typescript = lib.generators.mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        typescriptreact = lib.generators.mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';

        vue = lib.generators.mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        svelte = lib.generators.mkLuaInline ''
          { "biome", "prettierd", stop_after_first = true }
        '';
        astro = lib.generators.mkLuaInline ''
          { "biome", "prettierd", stop_after_first = true }
        '';

        graphql = lib.generators.mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        json = lib.generators.mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        jsonc = lib.generators.mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        html = lib.generators.mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        css = lib.generators.mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';

        yaml = lib.generators.mkLuaInline ''
          { "prettierd", "oxfmt", stop_after_first = true }
        '';
        markdown = lib.generators.mkLuaInline ''
          { "prettierd", "oxfmt", stop_after_first = true }
        '';
        mdx = lib.generators.mkLuaInline ''
          { "prettierd", "oxfmt", stop_after_first = true }
        '';

        toml = lib.generators.mkLuaInline ''
          { "oxfmt", stop_after_first = true }
        '';
      };
    };
  };
}
