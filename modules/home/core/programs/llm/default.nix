{
  flake.modules.homeManager.llm =
    {
      inputs,
      lib,
      pkgs,
      ...
    }:
    let
      llmAgents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};

      anthropicSkills = lib.genAttrs [
        "mcp-builder"
      ] (name: "${inputs.anthropic-skills}/skills/${name}");

      mattpocockSkills = lib.listToAttrs (
        map (path: {
          name = lib.last (lib.splitString "/" path);
          value = "${inputs.mattpocock-skills}/skills/${path}";
        }) [ "productivity/handoff" ]
      );

      localSkills = lib.mapAttrs (name: _: ./_skills + "/${name}") (
        lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./_skills)
      );

      skills = anthropicSkills // mattpocockSkills // localSkills;
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
        inherit skills;
        settings = {
          permission = {
            read = {
              "~/.ssh/id_*" = "deny";
              "**/.env" = "deny";
              "**/.env.local" = "deny";
            };
          };
        };
      };

      catppuccin.opencode.enable = true;

      programs.claude-code = {
        enable = true;
        enableMcpIntegration = true;
        package = llmAgents.claude-code;
        inherit skills;
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
                ${builtins.readFile ./claude-statusline-command.sh}
              ''
            );
          };
        };
      };

      home.shellAliases = {
        cc = "claude";
        oc = "opencode --auto";
      };
    };
}
