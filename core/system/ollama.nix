{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  programs = config.modules.programs;
in
{
  services = mkIf programs.ollama.enable {
    ollama = {
      enable = true;
      # package = pkgs.ollama-cuda;
      host = "127.0.0.1";
      port = 11434;
    };
    open-webui = {
      enable = true;
      host = "127.0.0.1";
      port = 8080;
      environment = {
        HOME = "/var/lib/open-webui";
      };
    };
  };
}
