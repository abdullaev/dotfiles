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

      sensitivePaths = [
        "~/.ssh/**"
        "/etc/ssh/ssh_host_*_key"
        "/run/agenix/**"
        "~/.gnupg/**"
        "~/.config/gh/hosts.yml"
        "~/.claude/.credentials.json"
        "~/.local/share/opencode/auth.json"
        "~/.local/share/fish/fish_history"
        "~/.local/share/kwalletd/**"
        "~/.netrc"
        "~/.git-credentials"
        "~/.npmrc"
        "~/.pypirc"
        "~/.cargo/credentials.toml"
        "~/.aws/credentials"
        "~/.kube/config"
        "~/.docker/config.json"
        "**/.env"
        "**/.env.local"
        "**/.env.production"
        "**/.env.development"
        "**/*.pem"
        "**/*.tfstate"
        "**/*.tfvars"
      ];
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
            read = lib.genAttrs sensitivePaths (_: "deny");
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
            deny = map (path: "Read(${path})") sensitivePaths;
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
        cl = "claude";
        oc = "opencode --auto";
      };
    };
}
