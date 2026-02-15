let
  users = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGvCNlV66FuuFEAl/ZCOp8e563qqHOUNq7arOpwBegTK sqxt@vega"
  ];

  systems = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL5WZ+NS5wrzmIviPSGiKZ3z4eamVdoj92IN478iRTl0 root@vega"
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
