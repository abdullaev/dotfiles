{
  flake.modules.homeManager.plasma = {
    programs.plasma.kwin = {
      virtualDesktops = {
        number = 4;
        rows = 1;
      };
      nightLight = {
        enable = true;
        mode = "location";
        location = {
          latitude = "55.7558";
          longitude = "37.6176";
        };
        temperature.night = 4000;
      };
    };
  };
}
