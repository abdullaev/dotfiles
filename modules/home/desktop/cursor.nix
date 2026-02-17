{
  flake.modules.homeManager.cursor = { pkgs, ... }: {
    home.packages = with pkgs; [
      code-cursor-fhs
    ];
  };
}
