{ stdenvNoCC, src }:

stdenvNoCC.mkDerivation {
  pname = "pragmata-pro";
  version = "0.903";
  inherit src;

  installPhase = ''
    runHook preInstall
    install -d "$out/share/fonts/opentype"
    install -m644 ./*.otf "$out/share/fonts/opentype/"
    runHook postInstall
  '';
}
