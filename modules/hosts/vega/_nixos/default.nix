{ lib, pkgs, users, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../../../secrets
  ];

  users.users = lib.mapAttrs (
    _: user:
    {
      isNormalUser = true;
      description = user.fullName;
      extraGroups = user.groups;
      home = user.homeDirectory;
      linger = user.linger;
      shell = pkgs.${user.shell};
    }
  ) users;

  programs.zsh.enable = lib.any (user: user.shell == "zsh") (lib.attrValues users);
}
