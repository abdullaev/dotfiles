{
  users = {
    sqxt = {
      ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGvCNlV66FuuFEAl/ZCOp8e563qqHOUNq7arOpwBegTK sqxt@vega";
      gpg = {
        signingKey = "893953708135FD11AE442B327D7F72C7DF82DD52";
      };
    };
  };

  hosts = {
    vega = {
      ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL5WZ+NS5wrzmIviPSGiKZ3z4eamVdoj92IN478iRTl0 root@vega";
      syncthing = "KFYITS5-JF3GLMZ-UJBJLT2-YKI3J5G-LHPD3T2-LBPDYR4-3X5JPQD-ESO5CQN";
    };
  };

  devices = {
    iphone = {
      syncthing = "57RHG5Q-FTPDGUW-SI5BOJS-65EDOMA-PP6BRT6-YCPRJ2P-GT3PSLA-TWZ2AAI";
    };

    boox = {
      syncthing = "56TELT3-CZ6PRCQ-6GQS3NJ-PZCL6E4-2CLTBVJ-EBSJGFT-LLMMMRQ-KFTIFQ2";
    };
  };
}
