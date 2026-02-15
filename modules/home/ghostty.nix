{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "Catppuccin Mocha";
      window-theme = "ghostty";
      adjust-cursor-thickness = 2;
      font-family = "monospace";
      font-size = 11;
      app-notifications = false;
      keybind = "global:ctrl+alt+q=toggle_quick_terminal";
    };
  };
}
