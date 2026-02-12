{ flakeData, ... }:
{
  perSystem =
    {
      pkgs,
      system,
      ...
    }:
    {
      formatter = pkgs.nixfmt-tree;
      checks = flakeData.checksBySystem.${system} or { };
    };
}
