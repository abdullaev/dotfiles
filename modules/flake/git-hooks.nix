{ inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];

  perSystem =
    { config, ... }:
    {
      pre-commit.settings.hooks.treefmt = {
        enable = true;
        package = config.treefmt.build.wrapper;
      };

      # Entering the shell (nix develop) installs the pre-commit hook
      devShells.default = config.pre-commit.devShell;
    };
}
