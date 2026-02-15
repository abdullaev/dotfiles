let
  users = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPSkw6okdTewICDtZ7Gyv3vBowM+l2u+rdgjNxf1ch5E"
  ];

  systems = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDum3Lcnb52VoJPWHcaxOjHNYYrmmQUXs0Qi9JlP5RLH"
  ];
in
{
  "rs-awg2-latvia.conf.age".publicKeys = users ++ systems;
  "rs-awg2-germany.conf.age".publicKeys = users ++ systems;
  "rs-awg2-poland.conf.age".publicKeys = users ++ systems;
  "rs-awg2-lithuania.conf.age".publicKeys = users ++ systems;
  "rs-awg2-netherlands.conf.age".publicKeys = users ++ systems;
  "rs-awg2-kazakhstan.conf.age".publicKeys = users ++ systems;
}
