{
  flake.modules.homeManager.gpg =
    {
      lib,
      pkgs,
      user,
      ...
    }:
    lib.mkIf user.gpg.enable {
      programs.gpg.enable = true;

      services.gpg-agent = {
        enable = true;
        defaultCacheTtl = 1800;
        maxCacheTtl = 7200;
        pinentry.package = pkgs.pinentry-qt;
        enableBashIntegration = user.shell == "bash";
        enableFishIntegration = user.shell == "fish";
        enableZshIntegration = user.shell == "zsh";
      };
    };
}
