{
  flake.modules.homeManager.firefox =
    { pkgs, config, ... }:
    {
      programs.firefox = {
        enable = true;
        # The upstream default for stateVersion >= 26.05; setting it opts in
        # early and silences the transition warning.
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
