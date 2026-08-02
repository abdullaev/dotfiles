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

      home.file.".config/process-compose/settings.yaml".text = ''
        theme: "Catppuccin ${lib.toSentenceCase config.catppuccin.flavor}"
      '';
    };
}
