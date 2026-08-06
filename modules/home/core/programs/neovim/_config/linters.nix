{ pkgs, lib }:
let
  inherit (lib.generators) mkLuaInline;

  js = [
    "eslint_d"
    "oxlint"
    "biomejs"
  ];
in
{
  # nvim-lint's builtins resolve ./node_modules/.bin/<tool> against the linter's
  # cwd first and fall back to a bare name on PATH; these are that fallback.
  # Deliberately NOT using vim.diagnostics.presets.{eslint_d,biomejs}: those set
  # `cmd` to an absolute store path, which replaces the builtin's lookup function
  # and pins every project to this flake's version of the tool.
  extraPackages = [
    pkgs.eslint_d
    pkgs.oxlint
    pkgs.stylelint
    pkgs.biome
  ];

  diagnostics.nvim-lint = {
    enable = true;

    linters.biomejs = {
      # The builtin parser scrapes biome's pretty output and only recognises the
      # `×` marker, so on biome 2.x every warning-level rule (printed as `!`) is
      # silently dropped. The github reporter is machine-readable instead. Biome
      # emits `title=` before `file=`, unlike oxlint, so it needs its own pattern.
      args = [
        "lint"
        "--reporter=github"
      ];
      parser = mkLuaInline ''
        require("lint.parser").from_pattern(
          "::([^ ]+) title=([^,]+),file=(.*),line=(%d+),endLine=(%d+),col=(%d+),endColumn=(%d+)::(.*)",
          { "severity", "code", "file", "lnum", "end_lnum", "col", "end_col", "message" },
          {
            error = vim.diagnostic.severity.ERROR,
            warning = vim.diagnostic.severity.WARN,
          },
          { source = "biome" },
          {}
        )
      '';
    };

    linters_by_ft = {
      javascript = js;
      javascriptreact = js;
      typescript = js;
      typescriptreact = js;
      vue = js;
      svelte = js;
      astro = js;

      json = [ "biomejs" ];
      jsonc = [ "biomejs" ];
      graphql = [ "biomejs" ];

      css = [
        "stylelint"
        "biomejs"
      ];
      scss = [ "stylelint" ];
      less = [ "stylelint" ];
    };

    # Same rule as formatters.nix: a linter whose config file we cannot find above
    # the buffer is a linter this project never asked for, so it does not run.
    #
    # nvf's default lint_function checks `required_files` against vim.fn.getcwd()
    # with no upward walk, so it only works when nvim was opened at the project
    # root. This walks up from the buffer instead, and passes the directory it
    # found as the linter's cwd -- which is what makes eslint_d pick up the
    # project's own eslint (it does require.resolve from process.cwd(), falling
    # back to its bundled v10) and what makes the builtins' node_modules/.bin
    # lookup resolve against the project rather than against nvim's cwd.
    lint_function = mkLuaInline ''
      function(buf)
        local lint = require("lint")
        local names = lint.linters_by_ft[vim.bo[buf].filetype]
        if names == nil then return end

        -- When a project has no eslint of its own, eslint_d falls back to its
        -- bundled copy and tries to write a daemon token next to it -- a
        -- read-only store path under Nix, so it hangs until it times out.
        -- "ignore" makes it exit quietly instead, which is the behaviour we
        -- want anyway: no project eslint, no linting.
        vim.env.ESLINT_D_MISS = "ignore"

        local bufname = vim.api.nvim_buf_get_name(buf)
        if bufname == "" then return end
        local dirname = vim.fs.dirname(bufname)

        local project_config = {
          eslint_d = {
            files = {
              "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs",
              "eslint.config.ts", "eslint.config.mts", "eslint.config.cts",
              ".eslintrc", ".eslintrc.js", ".eslintrc.cjs",
              ".eslintrc.json", ".eslintrc.yml", ".eslintrc.yaml",
            },
            package_key = "eslintConfig",
          },
          oxlint = {
            files = { ".oxlintrc.json", ".oxlintrc.jsonc" },
          },
          biomejs = {
            files = { "biome.json", "biome.jsonc", ".biome.json", ".biome.jsonc" },
          },
          stylelint = {
            files = {
              ".stylelintrc", ".stylelintrc.json", ".stylelintrc.yml", ".stylelintrc.yaml",
              ".stylelintrc.js", ".stylelintrc.cjs", ".stylelintrc.mjs",
              "stylelint.config.js", "stylelint.config.cjs", "stylelint.config.mjs",
            },
            package_key = "stylelint",
          },
        }

        local function has_package_key(dir, key)
          local fd = io.open(vim.fs.joinpath(dir, "package.json"), "r")
          if fd == nil then return false end
          local content = fd:read("*a")
          fd:close()
          local ok, data = pcall(vim.json.decode, content)
          return ok and type(data) == "table" and data[key] ~= nil
        end

        for _, name in ipairs(names) do
          local linter = lint.linters[name]
          if linter ~= nil then
            if type(linter) == "function" then linter = linter() end
            linter.name = linter.name or name

            local spec = project_config[name]
            if spec == nil then
              -- Not one of ours; keep nvf's default required_files behaviour.
              if linter.required_files == nil then
                lint.lint(linter)
              else
                for _, fname in ipairs(linter.required_files) do
                  if vim.uv.fs_stat(vim.fs.joinpath(linter.cwd or vim.fn.getcwd(), fname)) then
                    lint.lint(linter)
                    break
                  end
                end
              end
            else
              local root = vim.fs.root(dirname, function(fname, path)
                if vim.list_contains(spec.files, fname) then return true end
                if spec.package_key ~= nil and fname == "package.json" then
                  return has_package_key(path, spec.package_key)
                end
                return false
              end)
              if root ~= nil then
                lint.lint(linter, { cwd = root })
              end
            end
          end
        end
      end
    '';
  };
}
