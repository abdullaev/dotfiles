{
  den.aspects.llm.homeManager = {
      inputs,
      pkgs,
      ...
    }:
    let
      llmAgents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      programs.mcp = {
        enable = true;
        servers = {
          playwright = {
            command = "${pkgs.playwright-mcp}/bin/mcp-server-playwright";
            args = [
              "--headless"
              "--isolated"
            ];
          };
        };
      };

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
