{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";

      programs = {
        actionlint.enable = true;
        jsonfmt.enable = true;
        nixfmt.enable = true;
        shellcheck = {
          enable = true;
          severity = "warning";
        };
        shfmt = {
          enable = true;
          useEditorConfig = true;
        };
        stylua.enable = true;
        taplo.enable = true;
        yamlfmt.enable = true;
      };

      settings.formatter.yamlfmt.excludes = [
        "secrets/**"
      ];

      settings.global.excludes = [
        "modules/hosts/*/_nixos/hardware-configuration.nix"
      ];
    };
  };
}
