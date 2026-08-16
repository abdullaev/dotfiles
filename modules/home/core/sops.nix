{
  flake.modules.homeManager.sops =
    {
      user,
      lib,
      pkgs,
      ...
    }:
    let
      sshKeyPath = "${user.homeDirectory}/.ssh/id_ed25519";
    in
    {
      # Decrypt per-user secrets (secrets/users/<name>.yaml) with the user's
      # own SSH key — symlinked at ~/.config/sops-nix/secrets, generations in
      # $XDG_RUNTIME_DIR/secrets.d (user-owned tmpfs, gone on shutdown).
      # Runs as a user service at login (or boot, via linger).
      sops.age.sshKeyPaths = [ sshKeyPath ];

      home.sessionVariables.SOPS_AGE_KEY_CMD = "${lib.getExe pkgs.ssh-to-age} -private-key -i ${sshKeyPath}";
    };
}
