{
  lib,
  pkgs,
  users,
  ...
}:
let
  shellPackages = {
    bash = pkgs.bashInteractive;
    zsh = pkgs.zsh;
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ../../../../secrets
  ];

  users.users = lib.mapAttrs (_: user: {
    isNormalUser = true;
    description = user.fullName;
    extraGroups = user.groups;
    home = user.homeDirectory;
    linger = user.linger;
    shell = shellPackages.${user.shell};
  }) users;

  programs.zsh.enable = lib.any (user: user.shell == "zsh") (lib.attrValues users);
}
