{
  den.aspects.gpg = { user, ... }:
    let
      gpg = user.gpg or { };
      shell = user.shell or "zsh";
    in
    {
      homeManager =
        {
          lib,
          pkgs,
          ...
        }:
        lib.mkIf (gpg.enable or false) {
          programs.gpg.enable = true;

          services.gpg-agent = {
            enable = true;
            defaultCacheTtl = 1800;
            maxCacheTtl = 7200;
            pinentry.package = pkgs.pinentry-qt;
            enableBashIntegration = shell == "bash";
            enableFishIntegration = shell == "fish";
            enableZshIntegration = shell == "zsh";
          };
        };
    };
}
