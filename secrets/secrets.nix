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
  "vpn/rs-awg2-germany.conf.age".publicKeys = allKeys;
  "vpn/rs-awg2-poland.conf.age".publicKeys = allKeys;
  "vpn/rs-awg2-lithuania.conf.age".publicKeys = allKeys;
  "vpn/rs-awg2-netherlands.conf.age".publicKeys = allKeys;
  "vpn/rs-awg2-kazakhstan.conf.age".publicKeys = allKeys;
  "vpn/awg-estonia.conf.age".publicKeys = allKeys;
  "vpn/awg-poland.conf.age".publicKeys = allKeys;
  "vpn/awg-switzerland.conf.age".publicKeys = allKeys;
}
