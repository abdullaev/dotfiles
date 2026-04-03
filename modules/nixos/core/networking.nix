{
  den.aspects.networking.nixos = {
    networking.nftables.enable = true;
    networking.networkmanager.enable = true;

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
}
