{
  flake.modules.homeManager.base =
    {
      config,
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

      _module.args.catppuccinPalette =
        (lib.importJSON "${config.catppuccin.sources.palette}/palette.json")
        .${config.catppuccin.flavor}.colors;

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
