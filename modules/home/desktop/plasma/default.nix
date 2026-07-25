{
  flake.modules.homeManager.plasma = {
    programs.plasma = {
      enable = true;
      overrideConfig = true;

      resetFilesExclude = [
        "kdeglobals"
        "plasmarc"
      ];

      krunner = {
        position = "center";
      };

      session = {
        sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
      };

      configFile = {
        kded6rc = {
          "Module-browserintegrationreminder".autoload = false;
          PlasmaBrowserIntegration.shownCount = 100;
        };
      };
    };
  };
}
