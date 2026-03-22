{
  flake.modules.homeManager.btop =
    { pkgs, ... }:
    {
      programs.btop = {
        enable = true;
        package = pkgs.btop-cuda;
        settings = {
          theme_background = false;
          vim_keys = true;
          save_config_on_exit = false;
        };
      };

      catppuccin.btop.enable = true;
    };
}
