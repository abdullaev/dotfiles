{
  flake.modules.homeManager.plasma = {
    programs.plasma = {
      shortcuts = {
        "services/com.mitchellh.ghostty.desktop" = {
          "_launch" = "Meta+Return";
        };
      };
    };
  };
}
