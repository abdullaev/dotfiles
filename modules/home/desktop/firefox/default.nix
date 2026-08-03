{
  flake.modules.homeManager.firefox =
    { pkgs, config, ... }:
    {
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];

        profiles.default = {
          search.force = true;
          handlers.force = true;
        };
      };

      catppuccin.firefox = {
        profiles.default.enable = true;
        force = true;
      };
    };
}
