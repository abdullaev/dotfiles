{
  flake.modules.homeManager.firefox =
    { pkgs, ... }:
    let
      addons = pkgs.firefox-addons;
    in
    {
      programs.firefox.profiles.default = {
        extensions.packages = [
          addons.ublock-origin
          addons.sponsorblock
          addons.bitwarden
          addons.react-devtools
          addons.plasma-integration
          addons.firefox-color
        ];

        settings."extensions.autoDisableScopes" = 0;
      };
    };
}
