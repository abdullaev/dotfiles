{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    let
      pragmata-pro = pkgs.callPackage ../../../pkgs/pragmata-pro { };
    in
    {
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        nerd-fonts.symbols-only
        pragmata-pro
      ];

      fonts.fontconfig = {
        enable = true;
        useEmbeddedBitmaps = true;

        defaultFonts = {
          sansSerif = [
            "Noto Sans"
          ];

          serif = [
            "Noto Serif"
          ];

          monospace = [
            "PragmataPro Mono Liga"
          ];

          emoji = [
            "Noto Color Emoji"
          ];
        };

        localConf = ''
          <?xml version="1.0"?>
          <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
          <fontconfig>
            <alias>
              <family>ui-monospace</family>
              <prefer>
                <family>PragmataPro Mono Liga</family>
              </prefer>
            </alias>
          </fontconfig>
        '';
      };
    };
}
