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
      programs.mcp = {
        enable = true;
        servers = {
          playwright = {
            command = "${pkgs.playwright-mcp}/bin/playwright-mcp";
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

      programs.claude-code = {
        enable = true;
        enableMcpIntegration = true;
        package = llmAgents.claude-code;
      };

      home.file.".claude/settings.local.json".text = builtins.toJSON {
        theme = "dark-ansi";
        effortLevel = "xhigh";
        skipAutoPermissionPrompt = true;
      };

      catppuccin.opencode.enable = true;

      home.shellAliases = {
        cc = "claude";
        oc = "opencode";
      };
    };
}
