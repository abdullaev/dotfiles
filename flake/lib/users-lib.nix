{
  lib,
  hosts,
  users,
  profiles,
}:
let
  requiredUserFields = [
    "fullName"
    "email"
  ];

  mkUserDefaults = userName: {
    groups = [ ];
    shell = null;
    linger = false;
    isNormalUser = true;
    homeDirectory = "/home/${userName}";
    systemProfiles = [ ];
    homeProfiles = [ ];
    extraSystemModules = [ ];
    extraHomeModules = [ ];
  };

  getProfileModule =
    kind: profileName:
    if builtins.hasAttr profileName profiles.${kind} then
      profiles.${kind}.${profileName}
    else
      throw "Unknown ${kind} profile `${profileName}`.";

  resolveUser =
    hostName: userName:
    let
      hostConfig = hosts.${hostName};
      userConfig =
        if builtins.hasAttr userName users then
          users.${userName}
        else
          throw "Host `${hostName}` references unknown user `${userName}`.";
      hostOverrides = (hostConfig.userOverrides or { }).${userName} or { };
      mergedUser = mkUserDefaults userName // lib.recursiveUpdate userConfig hostOverrides;
      missingRequired = builtins.filter (field: !(builtins.hasAttr field mergedUser)) requiredUserFields;
    in
    if missingRequired != [ ] then
      throw "User `${userName}` is missing required fields: ${lib.concatStringsSep ", " missingRequired}"
    else
      mergedUser;

  resolveShellPackage =
    pkgs: userName: shellName:
    if shellName == null then
      null
    else if builtins.hasAttr shellName pkgs then
      pkgs.${shellName}
    else
      throw "User `${userName}` has unknown shell package `${shellName}`.";

  mkSystemUserModule =
    hostName: userName:
    let
      user = resolveUser hostName userName;
    in
    {
      pkgs,
      ...
    }:
    let
      shellName = user.shell;
      shellPackage = resolveShellPackage pkgs userName shellName;
    in
    {
      users.users.${userName} = {
        isNormalUser = user.isNormalUser;
        description = user.description or user.fullName;
        extraGroups = user.groups;
        home = user.homeDirectory;
      }
      // lib.optionalAttrs (shellPackage != null) {
        shell = shellPackage;
      }
      // lib.optionalAttrs user.linger {
        linger = true;
      };
    }
    // lib.optionalAttrs (shellName == "zsh") {
      programs.zsh.enable = true;
    };

  mkHomeUserModule =
    hostName: userName:
    let
      user = resolveUser hostName userName;
      homeProfileModules = map (profileName: getProfileModule "home" profileName) user.homeProfiles;
    in
    {
      imports = [ ../../home.nix ] ++ homeProfileModules ++ user.extraHomeModules;

      home.username = userName;
      home.homeDirectory = user.homeDirectory;

      programs.git.settings.user = {
        name = user.fullName;
        email = user.email;
      };
    };

  mkUserSystemModules =
    hostName: hostUsers:
    lib.concatMap (
      userName:
      let
        user = resolveUser hostName userName;
        profileModules = map (profileName: getProfileModule "system" profileName) user.systemProfiles;
      in
      profileModules ++ user.extraSystemModules ++ [ (mkSystemUserModule hostName userName) ]
    ) hostUsers;

  mkHomeUsers =
    hostName: hostUsers: lib.genAttrs hostUsers (userName: mkHomeUserModule hostName userName);
in
{
  inherit
    mkUserSystemModules
    mkHomeUsers
    ;
}
