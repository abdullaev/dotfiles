{
  flake.modules.nixos.location =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      # zone1970.tab maps every canonical timezone to its principal city's
      # coordinates in ISO 6709 (+DDMM+DDDMM or +DDMMSS+DDDMMSS).
      zoneTab = builtins.readFile "${pkgs.tzdata}/share/zoneinfo/zone1970.tab";

      rows = map (lib.splitString "\t") (
        lib.filter (line: line != "" && !lib.hasPrefix "#" line) (lib.splitString "\n" zoneTab)
      );

      coordsFor =
        tz:
        let
          row = lib.findFirst (row: lib.elemAt row 2 == tz) null rows;
          m = builtins.match "([+-])([0-9]{2})([0-9]{2})([0-9]{2})?([+-])([0-9]{3})([0-9]{2})([0-9]{2})?" (
            lib.elemAt row 1
          );
          toDecimal =
            sign: deg: min: sec:
            (if sign == "-" then -1.0 else 1.0)
            * (
              lib.toIntBase10 deg
              + lib.toIntBase10 min / 60.0
              + (if sec == null then 0.0 else lib.toIntBase10 sec / 3600.0)
            );
        in
        if row == null then
          throw "location: time.timeZone ${tz} has no coordinates in zone1970.tab; set location.latitude/longitude manually"
        else if m == null then
          throw "location: cannot parse coordinates '${lib.elemAt row 1}' for ${tz} in zone1970.tab; set location.latitude/longitude manually"
        else
          {
            latitude = toDecimal (lib.elemAt m 0) (lib.elemAt m 1) (lib.elemAt m 2) (lib.elemAt m 3);
            longitude = toDecimal (lib.elemAt m 4) (lib.elemAt m 5) (lib.elemAt m 6) (lib.elemAt m 7);
          };
    in
    lib.mkIf (config.time.timeZone != null) {
      location = {
        latitude = lib.mkDefault (coordsFor config.time.timeZone).latitude;
        longitude = lib.mkDefault (coordsFor config.time.timeZone).longitude;
      };
    };
}
