{
  flake.modules.homeManager.fzf = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      defaultOptions = [
        "--prompt='❭ '"
        "--pointer='▌'"
        "--highlight-line"
      ];
    };

    catppuccin.fzf.enable = true;
  };
}
