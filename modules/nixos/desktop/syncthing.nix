{
  flake.modules.nixos.syncthing =
    {
      config,
      lib,
      users,
      hostName,
      ...
    }:
    let
      keys = import ../../../shared/keys.nix;

      name = lib.head (lib.attrNames users);
      user = users.${name};
      group = config.users.users.${name}.group;

      peers = [
        hostName
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

      folders = lib.mapAttrs (_: folder: folderDefaults // folder) {
        sync = {
          path = "${user.homeDirectory}/Sync";
          label = "Sync";
        };

        documents = {
          path = "${user.homeDirectory}/Documents/Sync";
          label = "Documents";
        };

        music = {
          path = "${user.homeDirectory}/Music/Sync";
          label = "Music";
          type = "sendonly";
          versioning = null;
        };

        notes = {
          path = "${user.homeDirectory}/Notes/Sync";
          label = "Notes";

          ignorePatterns = [
            ".obsidian/appearance.json"
            ".obsidian/themes"
            ".obsidian/workspace.json"
            ".obsidian/workspace-mobile.json"
            ".trash"
          ];
        };

        video = {
          path = "${user.homeDirectory}/Videos/Sync";
          label = "Video";
          type = "sendonly";
          versioning = null;
        };
      };

      managedDirs = lib.filter (dir: dir != user.homeDirectory) (
        lib.unique (
          lib.concatMap (folder: [
            (builtins.dirOf folder.path)
            folder.path
          ]) (lib.attrValues folders)
        )
      );
    in
    {
      assertions = [
        {
          assertion = lib.length (lib.attrNames users) == 1;
          message = "flake.modules.nixos.syncthing runs as a single user; name one explicitly on multi-user hosts.";
        }
      ];

      services.syncthing = {
        enable = true;
        inherit group;
        user = name;

        dataDir = user.homeDirectory;
        configDir = "${user.homeDirectory}/.config/syncthing";

        guiAddress = "127.0.0.1:8384";

        openDefaultPorts = true;

        overrideDevices = true;
        overrideFolders = true;

        settings = {
          devices = {
            ${hostName}.id = keys.hosts.${hostName}.syncthing;
            iphone.id = keys.devices.iphone.syncthing;
          };

          inherit folders;

          options = {
            urAccepted = -1;
            crashReportingEnabled = false;
          };
        };
      };

      systemd.tmpfiles.rules = map (dir: "d ${dir} 0755 ${name} ${group} - -") managedDirs;
    };
}
