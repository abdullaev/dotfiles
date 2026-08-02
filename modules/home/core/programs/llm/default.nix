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

      obsidianSkills = lib.genAttrs [
        "defuddle"
        "json-canvas"
        "obsidian-bases"
        "obsidian-cli"
        "obsidian-markdown"
      ] (name: "${inputs.obsidian-skills}/skills/${name}");

      mattpocockSkills = lib.listToAttrs (
        map (path: {
          name = lib.last (lib.splitString "/" path);
          value = "${inputs.mattpocock-skills}/skills/${path}";
        }) [ "productivity/handoff" ]
      );

      herdrSkills = {
        herdr = pkgs.runCommand "herdr-skill" { } ''
          mkdir -p "$out"
          cp ${pkgs.herdr.src}/SKILL.md "$out/SKILL.md"
        '';
      };

      localSkills = lib.mapAttrs (name: _: ./_skills + "/${name}") (
        lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./_skills)
      );

      skills = anthropicSkills // obsidianSkills // mattpocockSkills // herdrSkills // localSkills;

      sensitivePaths = [
        "~/.ssh/**"
        "/etc/ssh/ssh_host_*_key"
        "/run/agenix/**"
        "~/.gnupg/**"
        "~/.config/gh/hosts.yml"
        "~/.claude/.credentials.json"
        "~/.local/share/opencode/auth.json"
        "~/.local/share/fish/fish_history"
        "~/.zsh_history"
        "~/.bash_history"
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

      # Claude Code reads a single leading slash as "relative to the settings
      # source" — for these settings that is ~/.claude, so `/run/agenix/**`
      # would guard ~/.claude/run/agenix. Only `//` anchors at the filesystem
      # root. `~/…` and bare `**/…` patterns mean the same to both agents.
      toClaudePattern = path: if lib.hasPrefix "/" path then "/${path}" else path;
    in
    {
      programs.mcp = {
        enable = true;
        servers = {
          playwright = {
            command = lib.getExe pkgs.playwright-mcp;
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
          theme = "dark-ansi";
          effortLevel = "xhigh";
          tui = "default";
          permissions = {
            defaultMode = "auto";
            deny = map (path: "Read(${toClaudePattern path})") sensitivePaths;
            disableBypassPermissionsMode = "disable";
          };
          statusLine = {
            type = "command";
            command = toString (
              pkgs.writeShellScript "claude-statusline" ''
                # `printf %.2f` parses floats locale-dependently.
                export LC_ALL=C
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
