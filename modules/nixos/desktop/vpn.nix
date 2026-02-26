{
  flake.modules.nixos.vpn =
    { config, ... }:
    {
      networking.wg-quick.interfaces.awg0 = {
        type = "amneziawg";
        configFile = config.age.secrets.awg-switzerland.path;
        autostart = true;
      };

      systemd.services."wg-quick-awg0".serviceConfig = {
        Restart = "on-failure";
        RestartSec = 10;
      };
    };
}
