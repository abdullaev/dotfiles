{
  flake.modules.nixos.steam =
    { pkgs, ... }:
    {
      programs = {
        steam = {
          enable = true;
          package = pkgs.steam.override {
            extraEnv = {
              MANGOHUD = "1";
              GAMEMODERUN = "1";
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

      environment.systemPackages = with pkgs; [
        mangohud
      ];
    };
}
