{
  flake.modules.homeManager.aseprite =
    { lib, pkgs, ... }:
    let
      catppuccinMochaExtension = pkgs.fetchurl {
        url = "https://github.com/catppuccin/aseprite/releases/download/v1.2.1/catppuccin-theme-mocha.aseprite-extension";
        hash = "sha256-embvGNZaGGim9JpWaigbIkt5NxHXpSI+2AaNkgKwMK4=";
      };

      catppuccinMochaTheme =
        pkgs.runCommand "catppuccin-theme-mocha"
          {
            nativeBuildInputs = [ pkgs.unzip ];
            src = catppuccinMochaExtension;
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
