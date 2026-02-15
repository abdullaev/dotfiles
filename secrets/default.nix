{
  age.identityPaths = [ "/etc/ssh/host_ed25519" ];

  age.secrets.rs-awg2-latvia = {
    file = ./rs-awg2-latvia.conf.age;
  };
  age.secrets.rs-awg2-germany = {
    file = ./rs-awg2-germany.conf.age;
  };
  age.secrets.rs-awg2-poland = {
    file = ./rs-awg2-poland.conf.age;
  };
  age.secrets.rs-awg2-kazakhstan = {
    file = ./rs-awg2-kazakhstan.conf.age;
  };
  age.secrets.rs-awg2-lithuania = {
    file = ./rs-awg2-lithuania.conf.age;
  };
  age.secrets.rs-awg2-netherlands = {
    file = ./rs-awg2-netherlands.conf.age;
  };
}
