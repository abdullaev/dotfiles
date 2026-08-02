{
  flake.modules.homeManager.process-compose =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        process-compose
      ];

      xdg.configFile."process-compose/settings.yaml".text = ''
        theme: "Catppuccin ${lib.toSentenceCase config.catppuccin.flavor}"
      '';
    };
}
