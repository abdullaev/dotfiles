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
    rs-awg2-latvia.file = ./vpn/rs-awg2-latvia.conf.age;
  };
}
