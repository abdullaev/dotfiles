{
  flake.modules.homeManager.base =
    {
      user,
      pkgs,
      inputs,
      ...
    }:
    {
      home = {
        username = user.name;
        homeDirectory = user.homeDirectory;
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
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
