let
  keys = import ../shared/keys.nix;

  userKeys = [
    keys.users.sqxt.ssh
  ];

  systemKeys = [
    keys.hosts.vega.ssh
  ];

  allKeys = userKeys ++ systemKeys;
in
{
  # misc
  "misc/access-tokens.age".publicKeys = allKeys;
  "misc/t-token-readonly.age".publicKeys = allKeys;

  # passwords
  "passwords/sqxt-at-vega.age".publicKeys = [
    keys.users.sqxt.ssh
    keys.hosts.vega.ssh
  ];
  "passwords/syncthing-gui.age".publicKeys = [
    keys.users.sqxt.ssh
    keys.hosts.vega.ssh
  ];

  # vpn
  "vpn/vpn.conf.age".publicKeys = allKeys;
}
