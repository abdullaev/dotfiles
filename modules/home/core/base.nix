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
      };

      home.packages = with pkgs; [
        wget
        lsof
        nil
        sqlite
        devenv
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
