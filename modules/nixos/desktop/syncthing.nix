{ root, ... }:
{
  # Mechanics only: single-user service wiring, gui password from sops, and
  # tmpfiles for whatever folders the host declares. Devices and folders are
  # personal topology and live with the host (e.g. modules/hosts/vega).
  flake.modules.nixos.syncthing =
    {
      config,
      lib,
      users,
      hostName,
      ...
    }:
    let
      keys = import (root + /shared/keys.nix);

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

      managedDirs = lib.filter (dir: dir != user.homeDirectory) (
        lib.unique (
          lib.concatMap (folder: [
            (builtins.dirOf folder.path)
            folder.path
          ]) (lib.attrValues config.services.syncthing.settings.folders)
        )
      );
    in
    {
      sops.secrets."syncthing/gui-password" = {
        sopsFile = root + "/secrets/hosts/${hostName}.yaml";
        owner = name;
        mode = "0400";
        restartUnits = [ "syncthing-init.service" ];
      };

      services.syncthing = {
        enable = true;
        inherit group;
        user = name;

        guiPasswordFile = config.sops.secrets."syncthing/gui-password".path;

        dataDir = user.homeDirectory;
        configDir = "${user.homeDirectory}/.config/syncthing";

        guiAddress = "127.0.0.1:8384";

        openDefaultPorts = true;

        overrideDevices = true;
        overrideFolders = true;

        settings = {
          devices.${hostName}.id = hostId;

          gui.user = name;

          options = {
            urAccepted = -1;
            crashReportingEnabled = false;
          };
        };
      };

      systemd.tmpfiles.rules = map (dir: "d ${dir} 0755 ${name} ${group} - -") managedDirs;
    };
}
