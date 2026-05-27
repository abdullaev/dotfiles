{
  flake.modules.homeManager.pob =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        rusty-path-of-building
      ];
    };
}
