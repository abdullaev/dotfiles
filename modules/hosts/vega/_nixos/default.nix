{
  inputs,
  lib,
  pkgs,
  users,
  ...
}:
let
  shellPackages = {
    bash = pkgs.bashInteractive;
    zsh = pkgs.zsh;
    fish = pkgs.fish;
  };
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware-configuration.nix
    ../../../../secrets
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32768;
    }
  ];

  users.users = lib.mapAttrs (
    _: user:
    {
      isNormalUser = true;
      description = user.fullName;
      extraGroups = user.groups;
      home = user.homeDirectory;
      linger = user.linger;
      shell = shellPackages.${user.shell};
    }
    // lib.optionalAttrs (user.authorizedKeys != [ ]) {
      openssh.authorizedKeys.keys = user.authorizedKeys;
    }
  ) users;

  programs.zsh.enable = lib.any (user: user.shell == "zsh") (lib.attrValues users);
  programs.fish.enable = lib.any (user: user.shell == "fish") (lib.attrValues users);
}
