{
  flake.modules.homeManager.skills =
    { inputs, lib, ... }:
    let
      anthropicSkills = lib.genAttrs [
        "mcp-builder"
      ] (name: "${inputs.anthropic-skills}/skills/${name}");

      mattpocockSkills = lib.listToAttrs (
        map (path: {
          name = lib.last (lib.splitString "/" path);
          value = "${inputs.mattpocock-skills}/skills/${path}";
        }) [ "productivity/handoff" ]
      );

      localSkills = lib.mapAttrs (name: _: ./skills + "/${name}") (
        lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./skills)
      );

      skills = anthropicSkills // mattpocockSkills // localSkills;
    in
    {
      programs.claude-code.skills = skills;
      programs.opencode.skills = skills;
    };
}
