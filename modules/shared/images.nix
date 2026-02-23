{
  lib,
  images,
  ...
}:
{
  options.images = lib.mkOption {
    type = with lib.types; attrsOf path;
    default = images;
  };
}
