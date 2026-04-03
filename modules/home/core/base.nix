{
  den.aspects.base = { user, ... }:
    let
      homeDirectory = user.homeDirectory or "/home/${user.userName}";
    in
    {
      homeManager =
        {
          pkgs,
          inputs,
          ...
        }:
        {
          home = {
            username = user.userName;
            homeDirectory = homeDirectory;
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
            inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
          ];
        };
    };
}
