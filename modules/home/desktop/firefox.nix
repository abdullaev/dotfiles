{
  flake.modules.homeManager.firefox =
    { pkgs, config, ... }:
    {
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        profiles.default = {
          settings = {
            "widget.use-xdg-desktop-portal.file-picker" = 1;
          };
        };
      };
    };
}
