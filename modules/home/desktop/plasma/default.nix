{
  flake.modules.homeManager.plasma = {
    programs.plasma = {
      enable = true;
      overrideConfig = true;

      krunner = {
        position = "center";
      };

      session = {
        sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
      };

      configFile = {
        # The "Get Plasma Browser Integration" reminder hides itself once
        # shownCount > 3, but overrideConfig wipes the counter on every
        # rebuild; declaring the "do not show again" state keeps it hidden.
        kded6rc = {
          "Module-browserintegrationreminder".autoload = false;
          PlasmaBrowserIntegration.shownCount = 100;
        };
      };
    };
  };
}
