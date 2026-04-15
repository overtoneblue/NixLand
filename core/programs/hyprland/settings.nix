{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (config) modules;
  inherit (modules) device;
  inherit (modules.style) pointerCursor;
in
{
  hm.wayland.windowManager.hyprland.extraConfig =
    let
      monitorConfig = builtins.concatStringsSep "\n" (
        builtins.map (monitor: "monitor=${monitor}") device.monitors
      );
      workspacesConfig = builtins.concatStringsSep "\n" (device.workspaces);
    in
    ''
      ${monitorConfig}
      ${workspacesConfig}
    '';

  hm.wayland.windowManager.hyprland = {
    settings = {

      "$mod" = "SUPER";
      exec-once = [
        "hyprctl setcursor ${pointerCursor.name} ${toString pointerCursor.size}"
        # "hyprsunset --temperature 5700"
      ];
      input = {
        follow_mouse = 1;
        sensitivity = 0;
      };
      cursor = {
        # allow_dumb_copy = true;
        no_hardware_cursors = true;
      };
      # experimental = {
      # xx_color_management_v4 = true;
      # };
      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 1;
        # "col.active_border" = "rgb(a0acc5)";
        # "col.inactive_border" = "rgb(7486a9)";
        allow_tearing = true;
        resize_on_border = true;
        layout = "master";
      };
      decoration = {
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
          # color = "rgb(3c4252)";
          # color_inactive = "rgb(3c4252)";
        };
        rounding = 8;
        # blur = {
        #   enabled = false;
        #   ignore_opacity = false;
        #   size = 8;
        #   passes = 2;
        # };
      };
      animations = {
        enabled = true;
        bezier = [
          "pace, 0.46, 1, 0.29, 0.99"
          "overshot, 0.13, 0.99, 0.29, 1.1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "custom, 0.5, 0.5, 0.6, 0.3"
        ];
        animation = [
          "windowsIn, 1, 1, custom, slide"
          "windowsOut, 1, 1, custom, slide"
          "windowsMove, 1, 1, custom, slide"
          "fade, 1, 1, custom"
          "workspaces, 1, 1.5, custom"
          "specialWorkspace, 1, 1, custom,slide"
        ];
      };
      render = {

      };
      dwindle = {
        pseudotile = false; # enable pseudotiling on dwindle
      };
      quirks = {
        prefer_hdr = 0;
      };
      # gestures = {
      #   workspace_swipe = false;
      # };
      plugin = {
        overview = {
          centerAligned = true;
          hideTopLayers = true;
          hideOverlayLayers = true;
          showNewWorkspace = true;
          exitOnClick = true;
          exitOnSwitch = true;
          drawActiveWorkspace = true;
          reverseSwipe = true;
        };
        # csgo-vulkan-fix = {
        #   res_w = 1920;
        #   res_h = 1080;
        #   class = "cs2";
        # };
      };
      misc = {
        animate_manual_resizes = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        vfr = 1;
        vrr = 1;
      };
    };
  };
}
