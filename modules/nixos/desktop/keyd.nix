{
  flake.modules.nixos.keyd = {
    services.keyd = {
      enable = true;
      keyboards.default.settings.main = {
        capslock = "overload(control, esc)";
      };
    };
  };
}
