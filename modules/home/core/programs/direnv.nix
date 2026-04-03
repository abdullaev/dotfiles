{
  den.aspects.direnv.homeManager = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;

      config = {
        global.warn_timeout = 0;
      };
    };
  };
}
