{
  flake.modules.nixos.fonts = _: {
    fonts.fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
    };
  };
}
