{
  flake.modules.homeManager.base =
    {
      user,
      pkgs,
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
