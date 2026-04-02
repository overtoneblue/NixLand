{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config) modules;
in
with lib;
{
  config = mkIf modules.programs.gaming.enable {
    environment.systemPackages = with pkgs; [
      protonplus
      # retroarch-full
      lutris
      # wineWowPackages.waylandFull
      # pokemmo-installer
      gamescope
      gamescope-wsi
      prismlauncher
    ];
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
    hm.programs.mangohud = {
      enable = true;
      settings = {
        fps_limit = "240,0,60,120,180";
        vsync = 1;
        gl_vsync = 0;
        cpu_stats = true;
        cpu_temp = true;
        gpu_stats = true;
        gpu_temp = true;
        vulkan_driver = false;
        fps = true;
        frametime = true;
        frame_timing = true;
        enableSessionWide = true;
        show_fps_limit = true;
        no_small_font = true;
        # font_size = 16;
        position = "top-left";
        engine_version = true;
        wine = true;
        no_display = false;
        # background_alpha = "0.0";
        toggle_hud = "Shift_R+F12";
        toggle_fps_limit = "Shift_R+F1";
      };
    };
  };
}
