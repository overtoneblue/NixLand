{ config, pkgs, ... }:
{
  config = {
    modules = {
      device = {
        type = "desktop";
        cpu = "amd";
        gpu = "nvidia";
        monitors = [
          "DP-2,2560x1440@239.97,1080x0,1"
          "DP-1,1920x1080@240,0x0,1,transform,1"
          "HDMI-A-1,3840x2160@60,auto,2"
        ];
        workspaces = [
          "workspace = 1, monitor:DP-2"
          "workspace = 2, monitor:DP-2"
          "workspace = 3, monitor:DP-2"
          "workspace = 4, monitor:DP-2"
          "workspace = 5, monitor:DP-2"
          "workspace = 6, monitor:DP-2"
          "workspace = 7, monitor:DP-1"
          "workspace = 8, monitor:DP-1"
          "workspace = 9, monitor:DP-1"
          "workspace = 10, monitor:HDMI-A-1"
        ];
        hasBluetooth = true;
        hasSound = true;
      };
      system = {
        username = "cenunix";
        boot = {
          loader = "systemd-boot";
        };
        video.enable = true;
        sound.enable = true;
        bluetooth.enable = true;
        virtualization.enable = true;
        virtualization.qemu.enable = true;
        virtualization.docker.enable = true;
        server = {
          enable = false;
          mediaServer = false;
        };
      };
      programs = {
        cli.enable = true;
        gui.enable = true;
        gpu-screen-recorder.enable = true;
        gaming = {
          enable = true;
          steam.enable = false;
          chess.enable = false;
          minecraft.enable = false;
          gamescope.enable = false;
        };
        default = {
          terminal = "wezterm";
          fileManager = "thunar";
        };
        override = { };
      };
      style = {
        pointerCursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };
      };
      usrEnv = {
        isWayland = true;
        desktop = "Hyprland";
        windowManager = true;
        useHomeManager = true;
        autologin = false;
      };
    };
  };
}
