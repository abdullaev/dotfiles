{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Consumed by home-manager (llm/t-invest.nix) via osConfig; the host
  # running sqxt's agents opts in to decrypting sqxt's token.
  sops.secrets."t-invest/token-readonly" = {
    sopsFile = ../../../../secrets/users/sqxt.yaml;
    owner = "sqxt";
    mode = "0400";
  };
}
