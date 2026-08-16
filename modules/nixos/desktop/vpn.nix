{ root, ... }:
{
  flake.modules.nixos.vpn =
    {
      config,
      inputs,
      lib,
      pkgs,
      hostName,
      ...
    }:
    let
      vpnIface = "awg0";
      ruTable = toString 51821;
      rulePrio = toString 100;
      # awg-quick would pick the first free table (51820) anyway; pinning it
      # via FwMark makes the kill switch's mark match immune to drift.
      wgFwMark = toString 51820;

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
              install -d -m 0755 ${stateDir}
              touch ${vpnOffFlag}
              systemctl stop wg-quick-${vpnIface}.service
              systemctl stop vpn-killswitch.service
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
                  install -d -m 0755 ${stateDir}
                  touch ${bypassOffFlag}
                  systemctl stop ru-direct-routes.service
                  ;;
                *) usage ;;
              esac
              ;;
            status)
              vpn_state="$(systemctl is-active wg-quick-${vpnIface}.service || true)"
              ks_state="$(systemctl is-active vpn-killswitch.service || true)"
              bypass_state="$(systemctl is-active ru-direct-routes.service || true)"
              [ -e ${vpnOffFlag} ] && vpn_state="$vpn_state (turned off)"
              [ -e ${bypassOffFlag} ] && bypass_state="$bypass_state (turned off)"
              echo "vpn:        $vpn_state"
              echo "killswitch: $ks_state"
              echo "bypass:     $bypass_state"
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
          apply_family 4 ${inputs.ru-ip-list}/ipv4.txt || rc=$?
          if [ "$rc" -ne 0 ]; then
            echo "IPv4 split tunnel failed (rc=$rc)" >&2
            exit 1
          fi

          rc=0
          apply_family 6 ${inputs.ru-ip-list}/ipv6.txt || rc=$?
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

      # Egress firewall for the fail-closed default: everything that is not
      # the tunnel itself, its marked encrypted packets, the RU split tunnel,
      # or local traffic (LAN, multicast, broadcast) is dropped. No port-53
      # accept: bootstrap DNS/DHCP servers are either on the LAN (RFC1918)
      # or Russian ISP resolvers already in @ru4, and a global 53 accept
      # would leak every query in plaintext whenever the tunnel is down.
      # `vpn off` removes it together with the tunnel, so only *failure*
      # fails closed.
      killswitchRules =
        pkgs.runCommand "vpn-killswitch.nft" { nativeBuildInputs = [ pkgs.buildPackages.nftables ]; }
          ''
            emit_set() {
              local name=$1 type=$2 file=$3
              echo "  set $name {"
              echo "    type $type"
              echo "    flags interval"
              echo "    auto-merge"
              if grep -q '[^[:space:]]' "$file"; then
                echo "    elements = {"
                awk 'NF { if (prev) print "      " prev ","; prev = $0 }
                     END { if (prev) print "      " prev }' "$file"
                echo "    }"
              fi
              echo "  }"
            }

            {
              echo 'table inet vpn-killswitch'
              echo 'delete table inet vpn-killswitch'
              echo 'table inet vpn-killswitch {'
              emit_set ru4 ipv4_addr ${inputs.ru-ip-list}/ipv4.txt
              emit_set ru6 ipv6_addr ${inputs.ru-ip-list}/ipv6.txt
              cat <<'EOF'
              chain output {
                type filter hook output priority filter; policy drop;
                oifname { "lo", "${vpnIface}" } accept
                meta mark ${wgFwMark} accept comment "tunnel's own encrypted packets"
                ip daddr { 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, 169.254.0.0/16, 224.0.0.0/4, 255.255.255.255 } accept comment "LAN, multicast, broadcast"
                ip6 daddr { fe80::/10, fc00::/7, ff00::/8 } accept comment "link-local, ULA, multicast"
                ip daddr @ru4 accept comment "split tunnel goes direct"
                ip6 daddr @ru6 accept
                counter comment "would-be leaks"
              }
            }
            EOF
            } > "$out"

            # Validate at build time so a bad ru-ip-list update fails the
            # build, not the boot. Same trick as the NixOS nftables module:
            # nft needs netlink even for --check, so run it against LKL's
            # userspace kernel, minus the delete (absent table there).
            sed '/^delete table/d' "$out" > check.conf
            NIX_REDIRECTS="/etc/protocols=${config.environment.etc.protocols.source}:/etc/services=${config.environment.etc.services.source}" \
              LD_PRELOAD="${pkgs.buildPackages.libredirect}/lib/libredirect.so ${pkgs.buildPackages.lklWithFirewall.lib}/lib/liblkl-hijack.so" \
              nft --check --file check.conf
          '';
    in
    {
      sops.secrets =
        lib.genAttrs
          [
            "vpn/private-key"
            "vpn/public-key"
            "vpn/endpoint"
            "vpn/allowed-ips"
            "vpn/junk-params"
            "vpn/address"
            "vpn/dns"
            "vpn/mtu"
          ]
          (_: {
            sopsFile = root + "/secrets/hosts/${hostName}.yaml";
          });

      sops.templates."${vpnIface}.conf" = {
        restartUnits = [ "wg-quick-${vpnIface}.service" ];
        content = ''
          [Interface]
          Address = ${config.sops.placeholder."vpn/address"}
          PrivateKey = ${config.sops.placeholder."vpn/private-key"}
          DNS = ${config.sops.placeholder."vpn/dns"}
          MTU = ${config.sops.placeholder."vpn/mtu"}
          FwMark = ${wgFwMark}

          ${config.sops.placeholder."vpn/junk-params"}

          [Peer]
          PublicKey = ${config.sops.placeholder."vpn/public-key"}
          AllowedIPs = ${config.sops.placeholder."vpn/allowed-ips"}
          Endpoint = ${config.sops.placeholder."vpn/endpoint"}
        '';
      };

      networking.wg-quick.interfaces.${vpnIface} = {
        type = "amneziawg";
        configFile = config.sops.templates."${vpnIface}.conf".path;
        autostart = true;
      };

      environment.systemPackages = [ vpnCtl ];

      # Fail closed: the kill switch outlives a crashed or start-limited
      # tunnel, so a dead VPN means no internet instead of a silent leak.
      # Only `vpn off` (which stops both units) is allowed to fail open.
      # Ordering before network-pre.target loads the rules before
      # NetworkManager brings any interface up, closing the boot window.
      systemd.services.vpn-killswitch = {
        description = "VPN kill switch: drop egress that bypasses ${vpnIface}";
        wantedBy = [ "multi-user.target" ];
        wants = [ "network-pre.target" ];
        before = [
          "network-pre.target"
          "wg-quick-${vpnIface}.service"
        ];
        unitConfig.ConditionPathExists = "!${vpnOffFlag}";
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${lib.getExe pkgs.nftables} -f ${killswitchRules}";
          ExecStop = "-${lib.getExe pkgs.nftables} delete table inet vpn-killswitch";
        };
      };

      systemd.services."wg-quick-${vpnIface}" = {
        after = [
          "network-online.target"
          "nss-lookup.target"
          "vpn-killswitch.service"
        ];
        wants = [
          "network-online.target"
          "nss-lookup.target"
        ];
        # requires, not wants: a kill switch that failed to load must block
        # the tunnel from starting instead of letting it run unprotected.
        requires = [ "vpn-killswitch.service" ];
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
