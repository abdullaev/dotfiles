{
  flake.modules.homeManager.firefox =
    { pkgs, config, ... }:
    {
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
        profiles.default = {
          settings = {
            "widget.use-xdg-desktop-portal.file-picker" = 1;
          };
        };
      };
    };
}
