{
  flake.modules.homeManager.sops =
    { user, ... }:
    {
      # Decrypt per-user secrets (secrets/users/<name>.yaml) with the user's
      # own SSH key into $XDG_RUNTIME_DIR/secrets — user-owned tmpfs, gone on
      # shutdown. Runs as a user service at login (or boot, via linger).
      sops.age.sshKeyPaths = [ "${user.homeDirectory}/.ssh/id_ed25519" ];
    };
}
