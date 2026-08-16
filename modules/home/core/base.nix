{
  flake.modules.homeManager.base =
    {
      user,
      pkgs,
      lib,
      ...
    }:
    {
      home = {
        username = user.name;
        inherit (user) homeDirectory;
      };

      catppuccin = {
        flavor = "mocha";
        accent = "lavender";
        autoEnable = false;
        enable = true;
      };

      home.sessionVariables.SOPS_AGE_KEY_CMD = "${lib.getExe pkgs.ssh-to-age} -private-key -i ${user.homeDirectory}/.ssh/id_ed25519";

      home.packages = with pkgs; [
        wget
        lsof
        sqlite
        python3
        defuddle
        sops
        ssh-to-age
      ];
    };
}
