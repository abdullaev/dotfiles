{
  flake.modules.homeManager.llm =
    {
      inputs,
      pkgs,
      ...
    }:
    let
      llmAgents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      programs.opencode = {
        enable = true;
        enableMcpIntegration = true;
        package = llmAgents.opencode;
        settings.permission = {
          external_directory = {
            "/nix/store/**" = "allow";
            "/tmp/**" = "allow";
          };
        };
      };

      catppuccin.opencode.enable = true;
    };
}
