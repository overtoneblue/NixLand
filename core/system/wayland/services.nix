{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
with lib;
let
  env = config.modules.usrEnv;
  programs = config.modules.programs;
in
{
  config = mkIf env.isWayland {
    services.xserver.enable = true;
    programs.obs-studio = mkIf programs.obs.enable {
      enable = true;

      # optional Nvidia hardware acceleration
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi # optional AMD hardware acceleration
        obs-gstreamer
        obs-vkcapture
      ];
    };
    environment.systemPackages =
      with pkgs;
      mkIf programs.gpu-screen-recorder.enable [
        gpu-screen-recorder
      ];

    systemd.services = {
      seatd = {
        enable = true;
        description = "Seat management daemon";
        script = "${pkgs.seatd}/bin/seatd -g wheel";
        serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = "1";
        };
        wantedBy = [ "multi-user.target" ];
      };
    };

    security = mkIf programs.gpu-screen-recorder.enable {
      wrappers = {
        gpu-screen-recorder = {
          owner = "root";
          group = "video";
          capabilities = "cap_sys_nice+ep";
          source = "${pkgs.gpu-screen-recorder}/bin/gpu-screen-recorder";
        };

        gsr-kms-server = {
          owner = "root";
          group = "video";
          capabilities = "cap_sys_admin+ep";
          source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
        };
      };
    };
  };
}
