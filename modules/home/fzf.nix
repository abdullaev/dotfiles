{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      "bg+" = "#313244";
      "fg" = "#cdd6f4";
      "fg+" = "#cdd6f4";
      "hl" = "#f38ba8";
      "hl+" = "#f38ba8";
      "info" = "#cba6f7";
      "marker" = "#b4befe";
      "pointer" = "#f5e0dc";
      "prompt" = "#cba6f7";
      "spinner" = "#f5e0dc";
      "border" = "#313244";
      "label" = "#cdd6f4";
    };
    defaultOptions = [
      "--prompt='❭ '"
      "--pointer='▌'"
      "--highlight-line"
    ];
  };
}
