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

  # passwords
  "passwords/sqxt-at-vega.age".publicKeys = [
    keys.users.sqxt.ssh
    keys.hosts.vega.ssh
  ];

  # vpn
  "vpn/rs-awg2-latvia.conf.age".publicKeys = allKeys;
}
