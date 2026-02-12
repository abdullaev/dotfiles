{ flakeData, ... }:
{
  flake.nixosConfigurations = flakeData.nixosConfigurations;
}
