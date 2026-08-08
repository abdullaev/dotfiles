{
  flake.modules.homeManager.llm =
    {
      config,
      inputs,
      lib,
      pkgs,
      user,
      ...
    }:
    {
      sops.secrets."t-invest/token-readonly" = {
        sopsFile = ../../../../../secrets/users + "/${user.name}.yaml";
      };

      programs.mcp.servers.t-invest = {
        command = lib.getExe pkgs.mcp-proxy;
        args = [
          "--transport=streamablehttp"
          "--verify-ssl=${inputs.russian-trusted-root-ca}"
          "https://invest-public-api.tbank.ru/mcp"
        ];
        env.API_ACCESS_TOKEN.file = config.sops.secrets."t-invest/token-readonly".path;
      };
    };
}
