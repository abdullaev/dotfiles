{
  flake.modules.homeManager.firefox =
    { pkgs, inputs, ... }:
    let
      addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
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
