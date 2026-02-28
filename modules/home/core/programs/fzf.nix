{
  flake.modules.homeManager.fzf =
    { lib, ... }:
    {
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
        colors = {
          bg = lib.mkForce "-1";
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
