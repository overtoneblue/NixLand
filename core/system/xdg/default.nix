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
  fileManager = config.modules.programs.default.fileManager;
  browser = [ "librewolf.desktop" ];
  zathura = [ "org.pwmt.zathura.desktop.desktop" ];
  videoPlayer = [ "mpv.desktop" ];
  # filemanager = [ "thunar.desktop" ];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    # --- Video ---
    "video/mp4" = videoPlayer;
    "video/mpeg" = videoPlayer;
    "video/quicktime" = videoPlayer;
    "video/x-matroska" = videoPlayer;
    "video/webm" = videoPlayer;
    "video/x-msvideo" = videoPlayer;
    "video/x-flv" = videoPlayer;
    "video/x-ms-wmv" = videoPlayer;
    "video/ogg" = videoPlayer;
    "video/3gpp" = videoPlayer;
    "video/3gpp2" = videoPlayer;
    "video/x-theora+ogg" = videoPlayer;
    "video/x-m4v" = videoPlayer;
    "video/dv" = videoPlayer;
    "video/avi" = videoPlayer;

    # --- Audio ---
    "audio/mpeg" = videoPlayer; # mp3
    "audio/mp4" = videoPlayer; # m4a
    "audio/aac" = videoPlayer;
    "audio/flac" = videoPlayer;
    "audio/ogg" = videoPlayer;
    "audio/opus" = videoPlayer;
    "audio/wav" = videoPlayer;
    "audio/x-wav" = videoPlayer;
    "audio/webm" = videoPlayer;
    "audio/x-ms-wma" = videoPlayer;
    "audio/x-aiff" = videoPlayer;
    "audio/x-matroska" = videoPlayer;

    "image/*" = [ "imv.desktop" ];
    "application/json" = browser;
    "application/pdf" = zathura;
    "x-scheme-handler/tg" = [ "telegramdesktop.desktop" ];
    "x-scheme-handler/spotify" = [ "spotify.desktop" ];
    "x-scheme-handler/discord" = [ "discord.desktop" ];
    "inode/directory" = [ "${fileManager}.desktop" ];
  };
in
{
  hm = {
    xdg = {
      enable = true;
      cacheHome = "${config.hm.home.homeDirectory}/.cache";
      configHome = "${config.hm.home.homeDirectory}/.config";
      dataHome = "${config.hm.home.homeDirectory}/.local/share";
      stateHome = "${config.hm.home.homeDirectory}/.local/state";

      userDirs = {
        enable = true;
        createDirectories = true;

        download = "${config.hm.home.homeDirectory}/Downloads";
        desktop = "${config.hm.home.homeDirectory}/Desktop";
        documents = "${config.hm.home.homeDirectory}/Documents";

        publicShare = "${config.hm.home.homeDirectory}/.local/share/public";
        templates = "${config.hm.home.homeDirectory}/.local/share/templates";

        music = "${config.hm.home.homeDirectory}/Media/Music";
        pictures = "${config.hm.home.homeDirectory}/Media/Pictures";
        videos = "${config.hm.home.homeDirectory}/Media/Videos";

        extraConfig = {
          SCREENSHOTS = "${config.hm.xdg.userDirs.pictures}/Screenshots";
        };
      };

      mimeApps = {
        enable = true;
        associations.added = associations;
        defaultApplications = associations;
      };

    };
  };
}
