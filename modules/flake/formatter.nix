{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";

      programs = {
        actionlint.enable = true;
        nixfmt.enable = true;
        shfmt.enable = true;
        shellcheck.enable = true;
        stylua.enable = true;
      };

      settings.formatter.shellcheck.options = [
        "--severity=warning"
      ];
    };
  };
}
