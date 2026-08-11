{
  flake.modules.homeManager.plasma =
    { osConfig, ... }:
    {
      programs.plasma = {
        kwin = {
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

        # The night-time daemon computes sunrise/sunset for night light;
        # Automatic=false pins it to the declared coordinates instead of GeoIP.
        configFile.knighttimerc.Location = {
          Automatic = false;
          Latitude = toString osConfig.location.latitude;
          Longitude = toString osConfig.location.longitude;
        };
      };
    };
}
