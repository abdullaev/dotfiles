{ root, ... }:
{
  flake.modules.homeManager.xdg =
    { lib, config, ... }:
    let
      mimetypes = import (root + /shared/mimetypes.nix);
      videoMimes = mimetypes.video;
      textMimes = mimetypes.text;

      firefoxOnlyMimes = [
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/x-extension-xht"
        "application/x-extension-xhtml"
        "application/xhtml+xml"
        "x-scheme-handler/chrome"
      ];

      forAll = mimes: apps: lib.genAttrs mimes (_: apps);
    in
    {
      xdg.mimeApps = {
        enable = true;

        defaultApplications =
          forAll videoMimes "mpv.desktop"
          // forAll textMimes "nvim.desktop"
          // forAll firefoxOnlyMimes "firefox.desktop"
          // {
            "text/html" = "firefox.desktop";
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "x-scheme-handler/geo" = "openstreetmap-geo-handler.desktop";
            "application/x-terminal-emulator" = "com.mitchellh.ghostty.desktop";
            "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
            "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
            "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
            "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
            "x-scheme-handler/obsidian" = "obsidian.desktop";
          };

        associations.added =
          forAll videoMimes "mpv.desktop"
          // forAll textMimes [
            "nvim.desktop"
          ]
          // forAll firefoxOnlyMimes "firefox.desktop"
          // {
            "text/html" = [
              "firefox.desktop"
              "google-chrome.desktop"
            ];
            "x-scheme-handler/http" = [
              "firefox.desktop"
              "google-chrome.desktop"
            ];
            "x-scheme-handler/https" = [
              "firefox.desktop"
              "google-chrome.desktop"
            ];
            "x-scheme-handler/geo" = [
              "openstreetmap-geo-handler.desktop"
              "google-maps-geo-handler.desktop"
            ];
            "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
            "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
            "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
            "x-scheme-handler/obsidian" = "obsidian.desktop";
          };
      };

      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = false;
        extraConfig.PROJECTS = "${config.home.homeDirectory}/Projects";
      };
    };
}
