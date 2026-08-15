{ inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];

  perSystem =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # Formatting is covered by the treefmt flake check; the hook's job is
      # to stop an accidentally decrypted secrets file from being committed.
      pre-commit.settings.hooks.sops-encrypted = {
        enable = true;
        name = "secrets are sops-encrypted";
        files = "^secrets/";
        types = [ "file" ];
        entry = lib.getExe (
          pkgs.writeShellApplication {
            name = "check-sops-encrypted";
            runtimeInputs = [
              pkgs.sops
              pkgs.jq
            ];
            text = ''
              rc=0
              for f in "$@"; do
                if [ "$(sops filestatus "$f" | jq .encrypted)" != "true" ]; then
                  echo "not sops-encrypted: $f" >&2
                  rc=1
                fi
              done
              exit "$rc"
            '';
          }
        );
      };

      # Entering the shell (nix develop) installs the pre-commit hook
      devShells.default = config.pre-commit.devShell;
    };
}
