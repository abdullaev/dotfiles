{
  flake.modules.nixos.steam =
    { pkgs, ... }:
    {
      boot.kernelModules = [ "ntsync" ];

      programs = {
        steam = {
          enable = true;
          package = pkgs.steam.override {
            extraEnv = {
              MANGOHUD = "1";
            };
          };
        };

        gamemode = {
          enable = true;
        };

        gamescope = {
          enable = true;
        };
      };
    };
}
