{ pkgs }:
{
  extraPlugins = with pkgs.vimPlugins; {
    sidekick-nvim = {
      package = sidekick-nvim;
      setup = builtins.readFile ./lua/sidekick-setup.lua;
    };
  };
}
