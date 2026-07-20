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
      };

      programs.claude-code = {
        enable = true;
        enableMcpIntegration = true;
        package = llmAgents.claude-code;
        settings = {
          model = "claude-fable-5";
          theme = "dark-ansi";
          effortLevel = "xhigh";
          tui = "default";
          permissions = {
            defaultMode = "auto";
            deny = [
              "Read(~/.ssh/id_*)"
              "Read(**/.env)"
              "Read(**/.env.local)"
            ];
            disableBypassPermissionsMode = "disable";
          };
          statusLine = {
            type = "command";
            command = toString (
              pkgs.writeShellScript "claude-statusline" ''
                export PATH=${
                  pkgs.lib.makeBinPath [
                    pkgs.jq
                    pkgs.coreutils
                  ]
                }:"$PATH"
                ${builtins.readFile ./statusline-command.sh}
              ''
            );
          };
        };
      };

      catppuccin.opencode.enable = true;

      home.shellAliases = {
        cc = "claude";
        oc = "opencode";
      };
    };
}
