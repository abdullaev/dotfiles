{
  den.aspects.keyd.nixos = {
    services.keyd = {
      enable = true;
      keyboards.default.settings.main = {
        capslock = "overload(control, esc)";
      };
    };
  };
}
