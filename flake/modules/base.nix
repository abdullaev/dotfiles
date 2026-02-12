{ inputs, ... }:
let
  flakeData = import ../lib/outputs-data.nix { inherit inputs; };
in
{
  systems = flakeData.systems;

  _module.args = {
    inherit flakeData;
  };
}
