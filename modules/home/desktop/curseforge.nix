{
  flake.modules.homeManager.curseforge = {
    programs.curseforge.enable = true;

    xdg.desktopEntries.curseforge-url-handler = {
      name = "CurseForge URL Handler";
      exec = "curseforge %u";
      icon = "curseforge";
      terminal = false;
      noDisplay = true;
      mimeType = [ "x-scheme-handler/cfauth" ];
    };
  };
}
