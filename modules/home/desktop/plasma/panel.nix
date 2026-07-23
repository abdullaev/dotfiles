{
  flake.modules.homeManager.plasma = {
    programs.plasma.panels = [
      {
        location = "bottom";
        floating = false;
        height = 44;
        widgets = [
          {
            kickoff = {
              icon = "nix-snowflake";
              showButtonsFor = {
                custom = [
                  "lock-screen"
                  "logout"
                  "reboot"
                  "shutdown"
                ];
              };
            };
          }
          "org.kde.plasma.pager"
          {
            iconTasks = {
              appearance = {
                showTooltips = true;
                iconSpacing = "medium";
              };
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:firefox.desktop"
                "applications:com.mitchellh.ghostty.desktop"
                "applications:org.telegram.desktop.desktop"
                "applications:discord.desktop"
                "applications:org.qbittorrent.qBittorrent.desktop"
                "applications:mpv.desktop"
                "applications:aseprite.desktop"
                "applications:steam.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          {
            digitalClock = {
              date.enable = false;
            };
          }
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
  };
}
