{
  flake.modules.nixos.vpn =
    { config, inputs, pkgs, ... }:
    let
      ruTable = 51821;
      rulePrio = 100;

      ruIpList = inputs.ru-ip-list;

      ruRoutesApply = pkgs.writeShellApplication {
        name = "ru-routes-apply";
        runtimeInputs = [
          pkgs.iproute2
          pkgs.jq
          pkgs.gawk
        ];
        text = ''
          set -euo pipefail
          read -r gw iface < <(
            ip -j -4 route show default \
              | jq -r 'map(select(.dev != "awg0"))[0] | "\(.gateway) \(.dev)"'
          )
          if [ -z "$gw" ] || [ "$gw" = "null" ] || [ -z "$iface" ]; then
            echo "No non-VPN default route" >&2
            exit 1
          fi

          ip route flush table ${toString ruTable} 2>/dev/null || true
          awk -v gw="$gw" -v dev="$iface" -v t=${toString ruTable} \
            '{ print "route add " $0 " via " gw " dev " dev " table " t }' \
            ${ruIpList} | ip -batch -

          ip rule add priority ${toString rulePrio} \
            lookup ${toString ruTable} 2>/dev/null || true

          echo "RU split tunnel active: table ${toString ruTable} via $gw dev $iface"
        '';
      };

      ruRoutesRemove = pkgs.writeShellApplication {
        name = "ru-routes-remove";
        runtimeInputs = [ pkgs.iproute2 ];
        text = ''
          ip rule del priority ${toString rulePrio} 2>/dev/null || true
          ip route flush table ${toString ruTable} 2>/dev/null || true
        '';
      };

      waitForDns = pkgs.writeShellApplication {
        name = "wg-wait-for-dns";
        runtimeInputs = [ pkgs.getent ];
        text = ''
          for i in $(seq 1 30); do
            if getent hosts cloudflare.com >/dev/null 2>&1; then
              echo "DNS ready after $i attempts"
              exit 0
            fi
            sleep 2
          done
          echo "DNS still not working after 60s; letting wg-quick try anyway"
        '';
      };
    in
    {
      networking.wg-quick.interfaces.awg0 = {
        type = "amneziawg";
        configFile = config.age.secrets.rs-awg2-latvia.path;
        autostart = true;
      };

      systemd.services."wg-quick-awg0" = {
        after = [
          "network-online.target"
          "nss-lookup.target"
        ];
        wants = [
          "network-online.target"
          "nss-lookup.target"
        ];
        serviceConfig = {
          ExecStartPre = "${waitForDns}/bin/wg-wait-for-dns";
          Restart = "on-failure";
          RestartSec = 15;
        };
        startLimitBurst = 5;
        startLimitIntervalSec = 180;
      };

      systemd.services.ru-direct-routes = {
        description = "Split tunnel: direct routes for Russian IPs";
        bindsTo = [ "wg-quick-awg0.service" ];
        after = [ "wg-quick-awg0.service" ];
        wantedBy = [ "wg-quick-awg0.service" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${ruRoutesApply}/bin/ru-routes-apply";
          ExecStop = "${ruRoutesRemove}/bin/ru-routes-remove";
        };
      };

      system.activationScripts.ru-direct-routes-start.text = ''
        if ${pkgs.systemd}/bin/systemctl is-active --quiet wg-quick-awg0.service; then
          ${pkgs.systemd}/bin/systemctl restart ru-direct-routes.service || true
        fi
      '';
    };
}
