let
  keys = import ../shared/keys.nix;

  userKeys = [
    keys.users.sqxt
  ];

  systemKeys = [
    keys.hosts.vega
  ];

  allKeys = userKeys ++ systemKeys;
in
{
  "access-tokens.age".publicKeys = allKeys;

  "rs-awg2-latvia.conf.age".publicKeys = allKeys;
  "rs-awg2-germany.conf.age".publicKeys = allKeys;
  "rs-awg2-poland.conf.age".publicKeys = allKeys;
  "rs-awg2-lithuania.conf.age".publicKeys = allKeys;
  "rs-awg2-netherlands.conf.age".publicKeys = allKeys;
  "rs-awg2-kazakhstan.conf.age".publicKeys = allKeys;
  "awg-estonia.conf.age".publicKeys = allKeys;
  "awg-poland.conf.age".publicKeys = allKeys;
  "awg-switzerland.conf.age".publicKeys = allKeys;
}
