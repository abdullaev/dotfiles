{
  den.aspects.process-compose.homeManager = { pkgs, ... }:
    {
      home.packages = with pkgs; [
        process-compose
      ];

      home.file.".config/process-compose/settings.yaml".text = ''
        theme: "Catppuccin Mocha"
      '';
    };
}
