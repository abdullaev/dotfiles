{
  flake.modules.homeManager.aseprite =
    { inputs, pkgs, ... }:
    let
      catppuccinMochaTheme =
        pkgs.runCommand "catppuccin-theme-mocha"
          {
            nativeBuildInputs = [ pkgs.unzip ];
            src = inputs.catppuccin-aseprite;
          }
          ''
            unzip -qq "$src"
            mkdir -p "$out"
            cp -r catppuccin-theme-mocha/. "$out"/
          '';
    in
    {
      home.packages = with pkgs; [
        aseprite
      ];

      home.file.".config/aseprite/extensions/catppuccin-theme-mocha" = {
        source = catppuccinMochaTheme;
        recursive = true;
      };
    };
}
