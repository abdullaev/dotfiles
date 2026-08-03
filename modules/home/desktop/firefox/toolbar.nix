{
  flake.modules.homeManager.firefox =
    {
      lib,
      pkgs,
      inputs,
      ...
    }:
    let
      addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};

      button =
        extensionId:
        let
          sanitized = lib.stringAsChars (c: if builtins.match "[a-z0-9_-]" c != null then c else "_") (
            lib.toLower extensionId
          );
        in
        "${sanitized}-browser-action";

      ublock = button addons.ublock-origin.addonId;
      sponsorblock = button addons.sponsorblock.addonId;
      bitwarden = button addons.bitwarden.addonId;
      seventv = button addons."7tv".addonId;
      reactDevtools = button addons.react-devtools.addonId;
      plasma = button addons.plasma-integration.addonId;
      firefoxColor = button addons.firefox-color.addonId;
    in
    {
      programs.firefox.profiles.default.settings = {
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 24;
          placements = {
            nav-bar = [
              "sidebar-button"
              "back-button"
              "forward-button"
              "stop-reload-button"
              "vertical-spacer"
              "urlbar-container"
              "downloads-button"
              "unified-extensions-button"
              sponsorblock
              seventv
              ublock
              reactDevtools
              bitwarden
              "reset-pbm-toolbar-button"
            ];
            unified-extensions-area = [
              plasma
              firefoxColor
            ];
            vertical-tabs = [ "tabbrowser-tabs" ];
            toolbar-menubar = [ "menubar-items" ];
            TabsToolbar = [ ];
            PersonalToolbar = [ "personal-bookmarks" ];
            widget-overflow-fixed-list = [ ];
          };
          seen = [
            "developer-button"
            "screenshot-button"
            reactDevtools
            bitwarden
            sponsorblock
            seventv
            ublock
            "reset-pbm-toolbar-button"
            plasma
            firefoxColor
          ];
        };

        "browser.proton.toolbar.version" = 3;
      };
    };
}
