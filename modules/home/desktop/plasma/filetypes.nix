{
  flake.modules.homeManager.plasma =
    { lib, ... }:
    let
      mimetypes = import ../../../../shared/mimetypes.nix;

      # Never show these inline in a KPart viewer — hand off to the
      # application chosen in mimeapps.list (see home/desktop/xdg.nix).
      noEmbedMimes = mimetypes.video ++ mimetypes.text ++ [ "x-scheme-handler/geo" ];
    in
    {
      programs.plasma.configFile.filetypesrc.EmbedSettings = lib.genAttrs (map (
        m: "embed-${m}"
      ) noEmbedMimes) (_: false);
    };
}
