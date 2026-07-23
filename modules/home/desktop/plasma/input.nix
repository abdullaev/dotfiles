{
  flake.modules.homeManager.plasma = {
    programs.plasma = {
      input.keyboard = {
        repeatDelay = 300;
        repeatRate = 50;
        layouts = [
          { layout = "us"; }
          { layout = "ru"; }
        ];
        options = [
          "grp:alt_shift_toggle"
        ];
      };

      configFile.kcminputrc."Libinput/Defaults" = {
        PointerAccelerationProfile = 1;
      };
    };
  };
}
