{ pkgs }:
{
  extraPlugins = with pkgs.vimPlugins; {
    codediff-nvim = {
      package = codediff-nvim;
      setup = "require('codediff').setup {}";
    };
  };
}
