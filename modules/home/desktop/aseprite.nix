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

      themeSources = {
        mocha = inputs.catppuccin-aseprite-mocha;
        latte = inputs.catppuccin-aseprite-latte;
      };

      catppuccinTheme =
        pkgs.runCommand "catppuccin-theme-${flavor}"
          {
            nativeBuildInputs = [ pkgs.unzip ];
            src =
              themeSources.${flavor}
                or (throw "aseprite: no catppuccin-aseprite-${flavor} flake input; add one in flake.nix");
          }
          ''
            unzip -qq "$src"
            mkdir -p "$out"
            cp -r catppuccin-theme-${flavor}/. "$out"/
          '';
    in
    {
      home.packages = with pkgs; [
        aseprite
      ];

      xdg.configFile."aseprite/extensions/catppuccin-theme-${flavor}" = {
        source = catppuccinTheme;
        recursive = true;
      };
    };
}
