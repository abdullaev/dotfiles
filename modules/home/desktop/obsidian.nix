{
  flake.modules.homeManager.obsidian = {
    programs.obsidian = {
      enable = true;

      defaultSettings.appearance = {
        theme = "obsidian";

        interfaceFontFamily = "sans-serif";
        textFontFamily = "sans-serif";
        monospaceFontFamily = "monospace";
      };

      vaults.notes = {
        target = "Notes/Sync";
      };
    };

    catppuccin.obsidian.enable = true;
  };
}
