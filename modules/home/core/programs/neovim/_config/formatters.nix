{ pkgs, lib }:
let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.meta) getExe;

  fromNodeModulesOrPackage = pkg: bin: mkLuaInline ''
    require("conform.util").find_executable({ "node_modules/.bin/${bin}" }, ${builtins.toJSON (getExe pkg)})
  '';
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
      formatters = {
        oxfmt = {
          command = fromNodeModulesOrPackage pkgs.oxfmt "oxfmt";
          args = [
            "--stdin-filepath"
            "$FILENAME"
          ];
          stdin = true;
          cwd = mkLuaInline ''
            require("conform.util").root_file({
              ".oxfmtrc.json",
              ".oxfmtrc.jsonc",
              "oxfmt.config.ts",
            })
          '';
        };

        biome = {
          command = fromNodeModulesOrPackage pkgs.biome "biome";
          args = [
            "check"
            "--write"
            "--stdin-file-path"
            "$FILENAME"
          ];
          stdin = true;
          require_cwd = true;
          cwd = mkLuaInline ''
            require("conform.util").root_file({
              "biome.json",
              "biome.jsonc",
              ".biome.json",
              ".biome.jsonc",
            })
          '';
        };

        prettierd = {
          command = fromNodeModulesOrPackage pkgs.prettierd "prettierd";
          args = [
            "--stdin"
            "--stdin-filepath"
            "$FILENAME"
          ];
          stdin = true;
          require_cwd = true;
          cwd = mkLuaInline ''
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
        javascript = mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        javascriptreact = mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        typescript = mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        typescriptreact = mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';

        vue = mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        svelte = mkLuaInline ''
          { "biome", "prettierd", stop_after_first = true }
        '';
        astro = mkLuaInline ''
          { "biome", "prettierd", stop_after_first = true }
        '';

        graphql = mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        json = mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        jsonc = mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        html = mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';
        css = mkLuaInline ''
          { "biome", "prettierd", "oxfmt", stop_after_first = true }
        '';

        yaml = mkLuaInline ''
          { "prettierd", "oxfmt", stop_after_first = true }
        '';
        markdown = mkLuaInline ''
          { "prettierd", "oxfmt", stop_after_first = true }
        '';
        mdx = mkLuaInline ''
          { "prettierd", "oxfmt", stop_after_first = true }
        '';

        toml = mkLuaInline ''
          { "oxfmt", stop_after_first = true }
        '';
      };
    };
  };
}
