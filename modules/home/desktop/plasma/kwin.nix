{
  flake.modules.homeManager.plasma =
    { osConfig, ... }:
    {
      programs.plasma.kwin = {
        virtualDesktops = {
          number = 4;
          rows = 1;
        };
        nightLight = {
          enable = true;
          mode = "location";
          location = {
            latitude = toString osConfig.location.latitude;
            longitude = toString osConfig.location.longitude;
          };
          temperature.night = 4000;
        };
      };
    };
}
