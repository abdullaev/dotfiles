{
  den.aspects.firefox.homeManager = { pkgs, ... }:
    {
      programs.firefox = {
        enable = true;
        profiles.default = {
          settings = {
            "widget.use-xdg-desktop-portal.file-picker" = 1;
          };
        };
      };
    };
}
