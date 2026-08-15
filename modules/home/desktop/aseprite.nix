{
  flake.modules.homeManager.aseprite =
    {
      config,
      inputs,
      pkgs,
      ...
    }:
    let
      inherit (config.catppuccin) flavor;
    in
    {
      home.packages = with pkgs; [
        aseprite
      ];

      xdg.configFile."aseprite/extensions/catppuccin-theme-${flavor}" = {
        source = "${inputs.catppuccin-aseprite}/themes/${flavor}/catppuccin-theme-${flavor}";
        recursive = true;
      };
    };
}
