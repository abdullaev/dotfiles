{
  flake.modules.homeManager.git =
    { pkgs, ... }:
    let
      catppuccinDeltaTheme = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "delta";
        rev = "74b47a345638a2f19b3e5bdb9d7e4984066f9ac7";
        sha256 = "sha256-NjqqB/BHqduiNWKeksiRZUMfjRUodJlsVu1yaEIZRsM=";
      };
    in
    {
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
          delta.features = "catppuccin-mocha";
        };
        includes = [
          {
            path = "${catppuccinDeltaTheme}/catppuccin.gitconfig";
          }
        ];
      };
    };
}
