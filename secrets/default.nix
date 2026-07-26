{
  age.secrets = {
    # misc
    access-tokens = {
      file = ./misc/access-tokens.age;
      group = "wheel";
      mode = "0440";
    };
    t-token-readonly = {
      file = ./misc/t-token-readonly.age;
      owner = "sqxt";
      mode = "0400";
    };

    # passwords
    sqxt-at-vega = {
      file = ./passwords/sqxt-at-vega.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
    syncthing-gui = {
      file = ./passwords/syncthing-gui.age;
      owner = "sqxt";
      mode = "0400";
    };

    # vpn
    vpn.file = ./vpn/vpn.conf.age;
  };
}
