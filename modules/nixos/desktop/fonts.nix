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
      };
    };
}
