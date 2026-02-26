{
  flake.modules.homeManager.delta =
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
      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          line-numbers = true;
          navigate = true;
          side-by-side = true;
        };
      };
      programs.git = {
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
