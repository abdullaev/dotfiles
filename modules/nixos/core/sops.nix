{
  flake.modules.nixos.sops = {
    sops = {
      # Decrypt with the SSH host key — same identity agenix used.
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      gnupg.sshKeyPaths = [ ];
    };
  };
}
