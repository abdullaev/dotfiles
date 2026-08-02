{
  flake.modules.homeManager.btop =
    { osConfig, pkgs, ... }:
    {
      programs.btop = {
        enable = true;
        package =
          if builtins.elem "nvidia" (osConfig.services.xserver.videoDrivers or [ ]) then
            pkgs.btop-cuda
          else
            pkgs.btop;
        settings = {
          theme_background = false;
          vim_keys = true;
          save_config_on_exit = false;
        };
      };

      catppuccin.btop.enable = true;
    };
}
