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

      # `throw` instead of an assertion: `name` is forced while evaluating the
      # config below, so an assertion could never fire first.
      name =
        if lib.length (lib.attrNames users) == 1 then
          lib.head (lib.attrNames users)
        else
          throw "flake.modules.nixos.syncthing expects exactly one user, got ${toString (lib.length (lib.attrNames users))}; name one explicitly on multi-user hosts.";
      user = users.${name};
      group = config.users.users.${name}.group;

      hostId =
        keys.hosts.${hostName}.syncthing
          or (throw "shared/keys.nix is missing hosts.${hostName}.syncthing for flake.modules.nixos.syncthing");

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
          devices = peers ++ [ "boox" ];
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
            ".obsidian"
            ".trash"
          ];
        };

        boox-notes = {
          path = "${user.homeDirectory}/Notes/Boox";
          label = "Boox Notes";
          type = "receiveonly";
          devices = [
            hostName
            "boox"
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
      services.syncthing = {
        enable = true;
        inherit group;
        user = name;

        guiPasswordFile = config.age.secrets.syncthing-gui.path;

        dataDir = user.homeDirectory;
        configDir = "${user.homeDirectory}/.config/syncthing";

        guiAddress = "127.0.0.1:8384";

        openDefaultPorts = true;

        overrideDevices = true;
        overrideFolders = true;

        settings = {
          devices = {
            ${hostName}.id = hostId;
            iphone.id = keys.devices.iphone.syncthing;
            boox.id = keys.devices.boox.syncthing;
          };

          gui.user = name;

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
