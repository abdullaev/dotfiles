{
  flake.modules.nixos.vpn = {
    programs.amnezia-vpn.enable = true;

    programs.throne = {
      enable = true;
      tunMode.enable = true;
    };
  };
}
