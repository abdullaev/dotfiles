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
    };
  };
}
