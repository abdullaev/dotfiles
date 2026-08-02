{
  perSystem =
    { pkgs, ... }:
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
      };
    };
}
