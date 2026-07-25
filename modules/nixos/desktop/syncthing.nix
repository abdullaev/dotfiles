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

      # Archives what Syncthing itself replaces or deletes, i.e. changes
      # arriving from a peer. Deletions made locally on this host are not
      # covered -- the file is already gone by the time it is noticed.
      versioning = {
        type = "simple";
        params = {
          keep = "10";
          cleanoutDays = "0";
        };
        cleanupIntervalS = 3600;
      };

      folders = {
        sync = {
          path = "${user.homeDirectory}/Sync";
          label = "Sync";
          type = "sendreceive";
          devices = peers;
          inherit versioning;
        };

        notes = {
          path = "${user.homeDirectory}/Notes/Sync";
          label = "Notes";
          type = "sendreceive";
          devices = peers;
          inherit versioning;

          # Obsidian rewrites its window state every time a vault is opened, on
          # each device independently. Syncing that earns a conflict a day and
          # nothing else.
          ignorePatterns = [
            ".obsidian/workspace.json"
            ".obsidian/workspace-mobile.json"
            ".trash"
          ];
        };

        video = {
          path = "${user.homeDirectory}/Videos/Sync";
          label = "Video";
          # One way: peers play what this host publishes and never push player
          # scratch files back. Versioning is deliberately absent -- a sendonly
          # folder never applies remote changes, so it could never fire.
          type = "sendonly";
          devices = peers;
        };
      };

      # Every sync root plus its parent, so tmpfiles does not get to invent
      # ~/Notes on its own and leave it owned by root. The home directory is
      # excluded: it is 0700 and a rule here would widen it to 0755.
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

        # Web UI stays on loopback; pair from http://127.0.0.1:8384.
        guiAddress = "127.0.0.1:8384";

        # TCP/UDP 22000 for transfers, UDP 21027 for local discovery.
        openDefaultPorts = true;

        # The settings below are authoritative: syncthing-init deletes any
        # device or folder added through the web UI that is absent here. New
        # peers get added to shared/keys.nix, not to the UI.
        overrideDevices = true;
        overrideFolders = true;

        settings = {
          # This host is listed because syncthing-init diffs against
          # /rest/config/devices, which includes the local device -- leaving it
          # out would make every rebuild try to delete the host from its own
          # config.
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
