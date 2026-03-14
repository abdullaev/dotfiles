{
  utility = {
    direnv.enable = true;
    nix-develop.enable = true;
    motion.flash-nvim = {
      enable = true;
      setupOpts = {
        prompt = {
          enabled = false;
        };
      };
    };
  };
}
