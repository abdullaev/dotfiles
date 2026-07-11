{ pkgs, lib }:
{
  lazy.plugins = {
    neogit = {
      package = lib.mkForce pkgs.vimPlugins.neogit;
    };
  };
}
