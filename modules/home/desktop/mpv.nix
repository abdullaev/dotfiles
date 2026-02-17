{
  flake.modules.homeManager.mpv = {
    programs.mpv = {
      enable = true;
      config = {
        background-color = "#1e1e2e";
        osd-back-color = "#11111b";
        osd-border-color = "#11111b";
        osd-color = "#cdd6f4";
        osd-shadow-color = "#1e1e2e";
      };
    };
  };
}
