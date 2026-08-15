{
  flake.modules.homeManager.llm =
    {
      config,
      inputs,
      lib,
      pkgs,
      ...
    }:
    let
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
          cp ${pkgs.herdr.src}/skills/herdr/SKILL.md "$out/SKILL.md"
        '';
      };

      localSkills = lib.mapAttrs (name: _: ./_skills + "/${name}") (
        lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./_skills)
      );

      skills = anthropicSkills // obsidianSkills // mattpocockSkills // herdrSkills // localSkills;

      sensitivePaths = [
        "~/.ssh/**"
        "/etc/ssh/ssh_host_*_key"
        "/run/secrets/**"
        "/run/secrets.d/**"
        "/run/secrets-for-users/**"
        "/run/user/*/secrets.d/**"
        "~/.config/sops-nix/**"
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
        "**/.env.staging"
        "**/.env.test"
        "**/*.pem"
        "**/*.tfstate"
        "**/*.tfvars"
      ];

      # Claude Code reads a single leading slash as "relative to the settings
      # source" — for these settings that is ~/.claude, so `/run/secrets/**`
      # would guard ~/.claude/run/secrets. Only `//` anchors at the filesystem
      # root. `~/…` and bare `**/…` patterns mean the same to both agents.
      toClaudePattern = path: if lib.hasPrefix "/" path then "/${path}" else path;

      claudeSettingsPath = "${config.programs.claude-code.configDir}/settings.json";

      palette =
        (lib.importJSON "${config.catppuccin.sources.palette}/palette.json")
        .${config.catppuccin.flavor}.colors;
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
        inherit skills;
        settings = {
          theme = "custom:dark-ansi-custom";
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

      home.file."${config.programs.claude-code.configDir}/themes/dark-ansi-custom.json".text =
        builtins.toJSON
          {
            name = "Dark ANSI Custom";
            base = "dark-ansi";
            overrides = {
              selectionBg = palette.surface1.hex;
              userMessageBackgroundHover = palette.surface0.hex;
            };
          };

      # `programs.claude-code.settings` links settings.json to a read-only store
      # path, but Claude Code persists runtime toggles (effort level, theme, …)
      # into that very file. Install a writable copy instead: nix stays the
      # source of truth, runtime edits live until the next activation.
      home.file.${claudeSettingsPath}.enable = false;

      home.activation.claudeCodeSettings = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
        run rm --force ${lib.escapeShellArg claudeSettingsPath}
        run install -Dm600 ${config.home.file.${claudeSettingsPath}.source} \
          ${lib.escapeShellArg claudeSettingsPath}
      '';

      home.shellAliases = {
        cl = "claude";
        oc = "opencode --auto";
      };
    };
}
