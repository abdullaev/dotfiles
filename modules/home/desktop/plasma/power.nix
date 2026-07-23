{
  flake.modules.homeManager.plasma =
    { config, ... }:
    {
      programs.plasma = {
        kscreenlocker = {
          appearance.wallpaper = config.programs.plasma.workspace.wallpaper;
          autoLock = true;
          timeout = 30;
          passwordRequired = true;
          passwordRequiredDelay = 0;
        };

        powerdevil = {
          AC = {
            powerProfile = "performance";
            autoSuspend.action = "nothing";
            turnOffDisplay = {
              idleTimeout = 1800;
              idleTimeoutWhenLocked = 300;
            };
            dimDisplay.idleTimeout = 900;
          };
        };
      };
    };
}
