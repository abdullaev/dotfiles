{
  inputs,
  lib,
  pkgs,
  users,
  config,
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

  users.mutableUsers = false;

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
    // lib.optionalAttrs (user.passwordSecret != null) {
      hashedPasswordFile = config.age.secrets.${user.passwordSecret}.path;
    }
  ) users;

  programs.zsh.enable = lib.any (user: user.shell == "zsh") (lib.attrValues users);
  programs.fish.enable = lib.any (user: user.shell == "fish") (lib.attrValues users);
}
