{
  lib,
  hosts,
  defaultHost,
}:
let
  defaultHostConfig = hosts.${defaultHost};
  hostNames = builtins.attrNames hosts;
  supportedSystems = lib.unique (map (hostName: hosts.${hostName}.system) hostNames);
  defaultSystem = defaultHostConfig.system;
  defaultUser = builtins.head defaultHostConfig.users;
in
{
  inherit
    defaultHost
    defaultHostConfig
    defaultSystem
    defaultUser
    hostNames
    supportedSystems
    ;
}
