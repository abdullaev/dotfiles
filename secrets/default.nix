{
  age.secrets = {
    # misc
    access-tokens = {
      file = ./misc/access-tokens.age;
      group = "wheel";
      mode = "0440";
    };

    # passwords
    sqxt-at-vega = {
      file = ./passwords/sqxt-at-vega.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };

    # vpn
    awg-estonia.file = ./vpn/awg-estonia.conf.age;
    awg-poland.file = ./vpn/awg-poland.conf.age;
    awg-switzerland.file = ./vpn/awg-switzerland.conf.age;
    rs-awg2-latvia.file = ./vpn/rs-awg2-latvia.conf.age;
    rs-awg2-germany.file = ./vpn/rs-awg2-germany.conf.age;
    rs-awg2-poland.file = ./vpn/rs-awg2-poland.conf.age;
    rs-awg2-kazakhstan.file = ./vpn/rs-awg2-kazakhstan.conf.age;
    rs-awg2-lithuania.file = ./vpn/rs-awg2-lithuania.conf.age;
    rs-awg2-netherlands.file = ./vpn/rs-awg2-netherlands.conf.age;
  };
}
