{
  flake.modules.homeManager.llm =
    {
      inputs,
      lib,
      osConfig,
      pkgs,
      ...
    }:
    {
      programs.mcp.servers.t-invest = {
        command = lib.getExe pkgs.mcp-proxy;
        args = [
          "--transport=streamablehttp"
          "--verify-ssl=${inputs.russian-trusted-root-ca}"
          "https://invest-public-api.tbank.ru/mcp"
        ];
        env.API_ACCESS_TOKEN.file = osConfig.sops.secrets."t-invest/token-readonly".path;
      };
    };
}
