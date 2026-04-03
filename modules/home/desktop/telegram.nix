{
  den.aspects.telegram.homeManager = { pkgs, ... }:
    {
      home.packages = with pkgs; [
        telegram-desktop
      ];
    };
}
