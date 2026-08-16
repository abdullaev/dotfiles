{ root, ... }:
let
  keys = import (root + /shared/keys.nix);

  peers = [
    "vega"
    "iphone"
  ];

  folderDefaults = {
    devices = peers;

    versioning = {
      type = "simple";
      params = {
        keep = "10";
        cleanoutDays = "0";
      };
      cleanupIntervalS = 3600;
    };
  };
in
{
  # Personal topology for flake.modules.nixos.syncthing (the desktop bundle
  # provides the service mechanics and derives tmpfiles from these folders).
  nixosHosts.vega.modules = [
    (
      { lib, users, ... }:
      let
        home = users.sqxt.homeDirectory;
      in
      {
        services.syncthing.settings = {
          devices = {
            iphone.id = keys.devices.iphone.syncthing;
            boox.id = keys.devices.boox.syncthing;
          };

          folders = lib.mapAttrs (_: folder: folderDefaults // folder) {
            sync = {
              path = "${home}/Sync";
              label = "Sync";
            };

            documents = {
              path = "${home}/Documents/Sync";
              label = "Documents";
              devices = peers ++ [ "boox" ];
            };

            music = {
              path = "${home}/Music/Sync";
              label = "Music";
              type = "sendonly";
              versioning = null;
            };

            notes = {
              path = "${home}/Notes/Sync";
              label = "Notes";

              ignorePatterns = [
                ".obsidian"
                ".trash"
              ];
            };

            boox-notes = {
              path = "${home}/Notes/Boox";
              label = "Boox Notes";
              type = "receiveonly";
              devices = [
                "vega"
                "boox"
              ];
            };

            video = {
              path = "${home}/Videos/Sync";
              label = "Video";
              type = "sendonly";
              versioning = null;
            };
          };
        };
      }
    )
  ];
}
