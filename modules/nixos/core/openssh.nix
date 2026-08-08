{
  flake.modules.nixos.openssh = {
    services.openssh = {
      enable = true;
      # Deliberate: sshd runs so host keys exist (sops-nix decrypts with them)
      # but is unreachable from any network. Flip this for LAN SSH.
      openFirewall = false;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
