{
  flake.modules.homeManager.plasma =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      ghostty = lib.getExe config.programs.ghostty.package;

      ghosttyHere = pkgs.writeShellScriptBin "ghostty-here" ''
        ${ghostty} +new-window --working-directory="$PWD" 2>/dev/null \
          || exec ${ghostty} --working-directory="$PWD"
      '';
    in
    {
      home.packages = [ ghosttyHere ];

      programs.plasma.configFile = {
        kdeglobals.General = {
          TerminalApplication = "ghostty-here";
          TerminalService = null;
        };

        kservicemenurc.Show.RunGhosttyDir = false;
      };
    };
}
