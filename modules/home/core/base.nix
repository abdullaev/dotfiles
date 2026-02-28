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

      home.packages = with pkgs; [
        wget
        lsof
        nil
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
