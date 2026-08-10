{
  perSystem =
    { config, pkgs, ... }:
    let
      lint =
        name: command:
        pkgs.runCommand "lint-${name}" { nativeBuildInputs = [ pkgs.${name} ]; } ''
          cd ${../../.}
          ${command}
          touch "$out"
        '';
    in
    {
      checks = {
        statix = lint "statix" "statix check .";
        deadnix = lint "deadnix" "deadnix --fail .";
        lint = pkgs.linkFarm "lint-checks" (
          removeAttrs config.checks [
            "nixos-hosts"
            "lint"
          ]
        );
      };
    };
}
