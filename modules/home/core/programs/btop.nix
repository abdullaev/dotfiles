{
  flake.modules.homeManager.btop = {
    programs.btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
        save_config_on_exit = false;
      };
    };

    catppuccin.btop.enable = true;
  };
}
