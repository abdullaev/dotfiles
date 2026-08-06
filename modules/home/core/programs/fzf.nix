{
  flake.modules.homeManager.fzf = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      colors = {
        bg = "-1";
      };
      defaultOptions = [
        "--prompt='❭ '"
        "--pointer='▌'"
        "--highlight-line"
      ];
    };

    catppuccin.fzf.enable = true;
  };
}
