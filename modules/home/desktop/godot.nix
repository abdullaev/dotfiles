{
  flake.modules.homeManager.godot =
    {
      lib,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        godot
      ];

      programs.mcp.servers.godot = {
        command = lib.getExe pkgs.godot-mcp;
        env.GODOT_PATH = lib.getExe pkgs.godot;
      };
    };
}
