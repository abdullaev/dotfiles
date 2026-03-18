{ pkgs, lib }:
let
  oxlintConfigFiles = [
    ".oxlintrc.json"
    ".oxlintrc.jsonc"
    "oxlint.config.ts"
  ];

  biomeConfigFiles = [
    "biome.json"
    "biome.jsonc"
    ".biome.json"
    ".biome.jsonc"
  ];

  eslintConfigFiles = [
    ".eslintrc"
    ".eslintrc.js"
    ".eslintrc.cjs"
    ".eslintrc.json"
    ".eslintrc.yml"
    ".eslintrc.yaml"
    "eslint.config.js"
    "eslint.config.cjs"
    "eslint.config.mjs"
    "eslint.config.ts"
    "eslint.config.mts"
    "eslint.config.cts"
  ];

  jsTsLinters = [
    "oxlint"
    "eslint_d"
    "biomejs"
  ];
in
{
  extraPackages = [
    pkgs.biome
    pkgs.eslint_d
    pkgs.oxlint
  ];

  diagnostics = {
    enable = true;
    config = {
      # virtual_text.enable = true;
      # virtual_lines.enable = true;
    };
    nvim-lint = {
      enable = true;
      lint_after_save = true;

      linters = {
        oxlint = {
          cmd = lib.meta.getExe pkgs.oxlint;
          stream = "stdout";
          args = [
            "--format"
            "github"
          ];
          ignore_exitcode = true;
          stdin = false;
          required_files = oxlintConfigFiles;
        };
        biomejs = {
          cmd = lib.meta.getExe pkgs.biome;
          stream = "both";
          args = [ "lint" ];
          ignore_exitcode = true;
          stdin = false;
          required_files = biomeConfigFiles;
        };
        eslint_d = {
          cmd = lib.meta.getExe pkgs.eslint_d;
          stream = "stdout";
          args = [
            "--format"
            "json"
            "--stdin"
            "--stdin-filename"
            (lib.generators.mkLuaInline "function() return vim.api.nvim_buf_get_name(0) end")
          ];
          ignore_exitcode = true;
          stdin = true;
          required_files = eslintConfigFiles;
        };
      };

      linters_by_ft = {
        javascript = jsTsLinters;
        javascriptreact = jsTsLinters;
        typescript = jsTsLinters;
        typescriptreact = jsTsLinters;
      };
    };
  };
}
