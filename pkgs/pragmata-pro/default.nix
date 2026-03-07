{ stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "pragmata-pro";
  version = "0.903";
  src = builtins.fetchGit {
    url = "https://github.com/abdullaev/font-pragmata-pro.git";
    rev = "5c08979930149e31386b1bda24844b3354fef8c4";
  };

  installPhase = ''
    runHook preInstall
    install -d "$out/share/fonts/opentype"
    install -m644 ./*.otf "$out/share/fonts/opentype/"
    runHook postInstall
  '';
}
