{ ... }:

{
  networking.wg-quick.interfaces.awg0 = {
    type = "amneziawg";
    configFile = "/etc/secrets/awg/Latvia.conf";
    autostart = true;
  };

  systemd.services."wg-quick-awg0".serviceConfig = {
    Restart = "on-failure";
    RestartSec = 10;
  };
}
