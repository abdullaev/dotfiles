{
  flake.modules.homeManager.plasma = {
    programs.plasma.fonts = {
      general = {
        family = "sans-serif";
        pointSize = 10;
      };
      fixedWidth = {
        family = "monospace";
        pointSize = 10;
      };
      small = {
        family = "sans-serif";
        pointSize = 8;
      };
      toolbar = {
        family = "sans-serif";
        pointSize = 10;
      };
      menu = {
        family = "sans-serif";
        pointSize = 10;
      };
      windowTitle = {
        family = "sans-serif";
        pointSize = 10;
      };
    };
  };
}
