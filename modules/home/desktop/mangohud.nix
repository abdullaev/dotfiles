{
  den.aspects.gaming.nixos = { pkgs, ... }: {
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

      gamemode.enable = true;
      gamescope.enable = true;
    };
  };

  den.aspects.gamingHome.homeManager = {
      programs.mangohud.enable = true;
      catppuccin.mangohud.enable = true;
  };
}
