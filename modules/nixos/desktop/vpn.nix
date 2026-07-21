{
  flake.modules.nixos.vpn =
    {
      config,
      inputs,
      lib,
      pkgs,
      ...
    }:
    let
      vpnIface = "awg0";
      ruTable = toString 51821;
      rulePrio = toString 100;

      stateDir = "/var/lib/vpn";
      vpnOffFlag = "${stateDir}/vpn-disabled";
      bypassOffFlag = "${stateDir}/bypass-disabled";

      vpnCtl = pkgs.writeShellApplication {
        name = "vpn";
        runtimeInputs = [
          pkgs.coreutils
          pkgs.systemd
        ];
        text = ''
          usage() {
            echo "usage: vpn [status | on | off | bypass on | bypass off]" >&2
            exit 2
          }

          case "''${1:-status}" in
            status | help | -h | --help) ;;
            *)
              if [ "$(id -u)" -ne 0 ]; then
                exec /run/wrappers/bin/sudo -- "$0" "$@"
              fi
              ;;
          esac

          case "''${1:-status}" in
            on)
              rm -f ${vpnOffFlag}
              systemctl reset-failed wg-quick-${vpnIface}.service 2>/dev/null || true
              systemctl start wg-quick-${vpnIface}.service
              ;;
            off)
              mkdir -p ${stateDir}
              touch ${vpnOffFlag}
              systemctl stop wg-quick-${vpnIface}.service
              ;;
            bypass)
              case "''${2:-}" in
                on)
                  rm -f ${bypassOffFlag}
                  if systemctl is-active --quiet wg-quick-${vpnIface}.service; then
                    systemctl start ru-direct-routes.service
                  fi
                  ;;
                off)
                  mkdir -p ${stateDir}
                  touch ${bypassOffFlag}
                  systemctl stop ru-direct-routes.service
                  ;;
                *) usage ;;
              esac
              ;;
            status)
              vpn_state="$(systemctl is-active wg-quick-${vpnIface}.service || true)"
              bypass_state="$(systemctl is-active ru-direct-routes.service || true)"
              [ -e ${vpnOffFlag} ] && vpn_state="$vpn_state (turned off)"
              [ -e ${bypassOffFlag} ] && bypass_state="$bypass_state (turned off)"
              echo "vpn:    $vpn_state"
              echo "bypass: $bypass_state"
              ;;
            *) usage ;;
          esac
        '';
      };

      ruRoutesApply = pkgs.writeShellApplication {
        name = "ru-routes-apply";
        runtimeInputs = [
          pkgs.iproute2
          pkgs.jq
          pkgs.gawk
        ];
        text = ''
          # Returns 1 if there is no usable non-VPN default route, 2 on any
          # real failure. Callers invoke this inside a condition, which
          # suspends errexit in the body, hence the explicit "|| return 2"s.
          apply_family() {
            local fam="$1" list="$2"
            local gw="" iface=""

            read -r gw iface < <(
              ip -j "-$fam" route show default 2>/dev/null \
                | jq -r 'map(select(.dev != "${vpnIface}"))[0] | "\(.gateway) \(.dev)"'
            ) || true

            if [ -z "$gw" ] || [ "$gw" = "null" ] || [ -z "$iface" ]; then
              return 1
            fi

            awk -v gw="$gw" -v dev="$iface" -v t=${ruTable} \
              'NF { print "route replace " $0 " via " gw " dev " dev " table " t }' \
              "$list" | ip "-$fam" -batch - || return 2

            if ! ip "-$fam" -j rule show | jq -e 'any(.priority == ${rulePrio})' >/dev/null; then
              ip "-$fam" rule add priority ${rulePrio} lookup ${ruTable} || return 2
            fi

            echo "RU split tunnel (IPv$fam) active: table ${ruTable} via $gw dev $iface"
          }

          rc=0
          apply_family 4 ${inputs.ru-ip-list} || rc=$?
          if [ "$rc" -ne 0 ]; then
            echo "IPv4 split tunnel failed (rc=$rc)" >&2
            exit 1
          fi

          rc=0
          apply_family 6 ${inputs.ru-ip-list-v6} || rc=$?
          if [ "$rc" -eq 1 ]; then
            echo "No non-VPN IPv6 default route; skipping IPv6"
          elif [ "$rc" -ne 0 ]; then
            echo "IPv6 split tunnel failed (rc=$rc)" >&2
            exit 1
          fi
        '';
      };

      ruRoutesRemove = pkgs.writeShellApplication {
        name = "ru-routes-remove";
        runtimeInputs = [ pkgs.iproute2 ];
        text = ''
          for fam in 4 6; do
            ip "-$fam" rule del priority ${rulePrio} 2>/dev/null || true
            ip "-$fam" route flush table ${ruTable} 2>/dev/null || true
          done
        '';
      };

      waitForDns = pkgs.writeShellApplication {
        name = "wg-wait-for-dns";
        runtimeInputs = [
          pkgs.coreutils
          pkgs.getent
        ];
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
      networking.wg-quick.interfaces.${vpnIface} = {
        type = "amneziawg";
        configFile = config.age.secrets.rs-awg2-latvia.path;
        autostart = true;
      };

      environment.systemPackages = [ vpnCtl ];

      systemd.services."wg-quick-${vpnIface}" = {
        after = [
          "network-online.target"
          "nss-lookup.target"
        ];
        wants = [
          "network-online.target"
          "nss-lookup.target"
        ];
        unitConfig.ConditionPathExists = "!${vpnOffFlag}";
        serviceConfig = {
          ExecStartPre = lib.getExe waitForDns;
          Restart = "on-failure";
          RestartSec = 15;
        };
        startLimitBurst = 5;
        startLimitIntervalSec = 180;
      };

      systemd.services.ru-direct-routes = {
        description = "Split tunnel: direct routes for Russian IPs";
        bindsTo = [ "wg-quick-${vpnIface}.service" ];
        after = [ "wg-quick-${vpnIface}.service" ];
        wantedBy = [ "wg-quick-${vpnIface}.service" ];
        unitConfig.ConditionPathExists = "!${bypassOffFlag}";
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = lib.getExe ruRoutesApply;
          ExecStopPost = lib.getExe ruRoutesRemove;
        };
      };

      # Reapply direct routes when the default route may have changed
      # (roaming, DHCP renew), and recover wg-quick if it exhausted its
      # start limit while offline. A manually stopped (not failed) VPN is
      # left alone.
      networking.networkmanager.dispatcherScripts = [
        {
          source = pkgs.writeText "ru-routes-dispatcher" ''
            #!${pkgs.runtimeShell}
            case "$2" in
              up | dhcp4-change | dhcp6-change | connectivity-change) ;;
              *) exit 0 ;;
            esac
            if [ "$1" = "${vpnIface}" ]; then
              exit 0
            fi

            systemctl=${lib.getExe' pkgs.systemd "systemctl"}
            if "$systemctl" is-active --quiet wg-quick-${vpnIface}.service; then
              "$systemctl" restart --no-block ru-direct-routes.service || true
            elif "$systemctl" is-failed --quiet wg-quick-${vpnIface}.service; then
              "$systemctl" reset-failed wg-quick-${vpnIface}.service || true
              "$systemctl" start --no-block wg-quick-${vpnIface}.service || true
            fi
          '';
        }
      ];
    };
}
