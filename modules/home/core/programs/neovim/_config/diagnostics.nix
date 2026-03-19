{ pkgs, lib }:
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
          required_files = [
            ".oxlintrc.json"
            ".oxlintrc.jsonc"
            "oxlint.config.ts"
          ];
        };
        biomejs = {
          cmd = lib.meta.getExe pkgs.biome;
          stream = "both";
          args = [ "lint" ];
          ignore_exitcode = true;
          stdin = false;
          required_files = [
            "biome.json"
            "biome.jsonc"
            ".biome.json"
            ".biome.jsonc"
          ];
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
          required_files = [
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
        };
      };

      linters_by_ft = {
        javascript = [
          "oxlint"
          "eslint_d"
          "biomejs"
        ];
        javascriptreact = [
          "oxlint"
          "eslint_d"
          "biomejs"
        ];
        typescript = [
          "oxlint"
          "eslint_d"
          "biomejs"
        ];
        typescriptreact = [
          "oxlint"
          "eslint_d"
          "biomejs"
        ];
        vue = [
          "oxlint"
          "biomejs"
          "eslint_d"
        ];
        svelte = [
          "oxlint"
          "biomejs"
          "eslint_d"
        ];
        astro = [
          "oxlint"
          "biomejs"
          "eslint_d"
        ];

        json = [ "biomejs" ];
        jsonc = [ "biomejs" ];
        css = [ "biomejs" ];
        graphql = [ "biomejs" ];
        html = [ "biomejs" ];
      };
    };
  };
}
