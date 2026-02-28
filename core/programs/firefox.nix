{
  config,
  inputs,
  lib,
  pkgs,
  osConfig,
  ...
}:
with lib;
let
  device = config.modules.device;
  acceptedTypes = [
    "desktop"
    "laptop"
    "armlaptop"
  ];
  startpage = pkgs.substituteAll { src = ./startpage.html; };
  user = config.modules.system.username;
  addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
  colors = config.lib.stylix.colors.withHashtag;
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    hm.programs = {
      librewolf = mkForce {
        enable = true;
        package = pkgs.librewolf;
        policies = {
          Cookies = {
            Allow = [
              "https://Kagi.com"
              "https://discord.com"
              "https://github.com"
              "https://boot.dev"
              "https://proton.me"
              "https://openai.com"
              "https://youtube.com"
              "https://chatgpt.com"
            ];
          };
          Homepage = {
            StartPage = "homepage";
            URL = "https://my.wgu.edu/";
            Locked = true;

            Additional = [
              "https://boot.dev/"
              "https://docs.aws.amazon.com"
              "https://kubernetes.io/docs/home/"
              "file:///home/youruser/notes/today.md"
            ];
          };
        };
        profiles.cenunix = {
          name = "cenunix";
          isDefault = true;
          search = {
            engines = {
              "kagi" = {
                urls = [ { template = "https://kagi.com/search?q={searchTerms}"; } ];
                icon = "https://kagi.com/favicon.ico";
              };
              "bing".metaData.hidden = true;
            };
            force = true;
            default = "kagi";
            privateDefault = "kagi";
            order = [
              "kagi"
            ];
          };
          extensions = {
            force = true;
            packages = with addons; [
              ublock-origin
              bitwarden
              darkreader
              vimium-c
              purpleadblock
            ];
            settings = {
              darkreader = {
                force = true;
                settings = {
                  enabled = true;
                  theme = {
                    mode = 1;
                    darkSchemeBackgroundColor = colors.base00;
                    darkSchemeTextColor = colors.base05;
                  };
                  previewNewDesign = true;
                };
              };
            };
          };
          bookmarks = { };
          settings = {
            "extensions.autoDisableScopes" = 0;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            # ctrl_alt Z to toggle sidebar expansions
            "sidebar.verticalTabs" = true;
            "sidebar.revamp" = true;
            # "browser.startup.homepage" = "https://docs.python.org/3/";
            "browser.uiCustomization.state" = builtins.toJSON {
              currentVersion = 20;
              newElementCount = 5;
              dirtyAreaCache = [
                "nav-bar"
                "PersonalToolbar"
                "toolbar-menubar"
                "TabsToolbar"
                "widget-overflow-fixed-list"
              ];
              placements = {
                PersonalToolbar = [ ];
                TabsToolbar = [
                  "tabbrowser-tabs"
                  "new-tab-button"
                  "alltabs-button"
                ];
                nav-bar = [
                  "back-button"
                  "forward-button"
                  "stop-reload-button"
                  "urlbar-container"
                  "downloads-button"
                  "ublock0_raymondhill_net-browser-action"
                  "_testpilot-containers-browser-action"
                  "reset-pbm-toolbar-button"
                  "unified-extensions-button"
                ];
                toolbar-menubar = [ "menubar-items" ];
                unified-extensions-area = [ ];
                widget-overflow-fixed-list = [ ];
              };
              seen = [
                "save-to-pocket-button"
                "developer-button"
                "ublock0_raymondhill_net-browser-action"
                "_testpilot-containers-browser-action"
              ];
            };
          };
          userContent = ''
            /* All internal about: pages */
            @-moz-document url-prefix("about:"), url-prefix("chrome:") {
              :root {
                /* Core in-content variables */
                --in-content-page-background:        ${colors.base00} !important;
                --in-content-box-background:         ${colors.base00} !important;
                --in-content-box-background-odd:     ${colors.base00} !important;
                --in-content-table-background:       ${colors.base00} !important;
                --in-content-table-header-background:${colors.base00} !important;
                --in-content-dialog-header-background:${colors.base00} !important;
                --in-content-box-info-background:    ${colors.base00} !important;

                --in-content-border-color:           ${colors.base02} !important;
                --in-content-box-border-color:       ${colors.base02} !important;
                --card-outline-color:                ${colors.base02} !important;

                --in-content-page-color:             ${colors.base05} !important;
                --in-content-text-color:             ${colors.base05} !important;
              }

              html, body {
                background-color: ${colors.base00} !important;
                color: ${colors.base05} !important;
              }

              /* Generic form elements on these pages */
              input, textarea, select {
                background-color: ${colors.base00} !important;
                color: ${colors.base05} !important;
                border-color: ${colors.base02} !important;
                box-shadow: none !important;
              }
            }

            /* 2. about:config specific bits (search bar/header that like to ignore vars) */
            @-moz-document url("about:config") {
              :root, html, body {
                background-color: ${colors.base00} !important;
                color: ${colors.base05} !important;
              }

              .sticky-container,
              #config-main,
              #config-container {
                background-color: ${colors.base00} !important;
              }

              #about-config-search,
              .config-search input[type="search"] {
                -moz-appearance: none !important;
                background-color: ${colors.base00} !important;
                color: ${colors.base05} !important;
                border: 1px solid ${colors.base02} !important;
                box-shadow: none !important;
              }
            }
                  
          '';
          userChrome = ''
            :root,
            :root[lwtheme],
            #main-window {
              /* Your palette */
              --my-bg: ${colors.base00} !important;
              --my-bg-2: ${colors.base01} !important;
              --my-fg: ${colors.base05} !important;
              --my-hi: ${colors.base04} !important;

              /* Window / theme frame */
              --lwt-frame: var(--my-bg) !important;
              --lwt-accent-color: var(--my-bg) !important;
              --lwt-text-color: var(--my-fg) !important;

              /* Toolbars */
              --toolbar-bgcolor: var(--my-bg) !important;
              --toolbar-color: var(--my-fg) !important;

              /* URL bar / fields */
              --toolbar-field-background-color: var(--my-bg) !important;
              --toolbar-field-focus-background-color: var(--my-bg) !important;
              --toolbar-field-color: var(--my-fg) !important;
              --toolbar-field-focus-color: var(--my-fg) !important;
              --input-bgcolor: var(--my-bg) !important;
              --input-color: var(--my-fg) !important;

              /* Panels / menus */
              --panel-background: var(--my-bg) !important;
              --panel-color: var(--my-fg) !important;
              --arrowpanel-background: var(--my-bg) !important;
              --arrowpanel-color: var(--my-fg) !important;
              --arrowpanel-border-color: var(--my-bg-2) !important;
              --panel-separator-color: var(--my-bg-2) !important;

              /* Sidebar (native sidebar + vertical tabs) */
              --sidebar-background-color: var(--my-bg) !important;
              --sidebar-text-color: var(--my-fg) !important;
              --sidebar-border-color: var(--my-bg-2) !important;

              /* NEW: Firefox 146-ish vertical-tabs / sidebar pane surface */
              --tabpane-background-color: var(--my-bg) !important;     /* this was #2b2a33 in your screenshot */
              --tabpanel-background-color: var(--my-bg) !important;    /* sometimes used alongside tabpane */
              --tab-hover-background-color: var(--my-bg-2) !important; /* hover blend that can look “default” */

              /* Buttons / hover states (often the “mystery gray”) */
              --button-background-color: var(--my-bg-2) !important;
              --button-color: var(--my-fg) !important;

              --toolbarbutton-icon-fill: var(--my-fg) !important;
              --toolbarbutton-hover-background: var(--my-bg-2) !important;
              --toolbarbutton-active-background: var(--my-bg-2) !important;

              /* Separators that sometimes show default theme color */
              --tabs-navbar-separator-color: var(--my-bg) !important;
              --chrome-content-separator-color: var(--my-bg) !important;

              /* Optional highlight colors */
              --urlbarView-highlight-color: var(--my-fg) !important;
              --urlbarView-highlight-background: var(--my-hi) !important;

              /* Keep titlebar opacity consistent */
              --inactive-titlebar-opacity: 1.0 !important;            
            }
            #TabsToolbar {
              visibility: collapse !important;
            }
            #PersonalToolbar,
            #toolbar,
            #nav-bar {
              background-color: ${colors.base00} !important;
              background-image: none !important;
            }
            tab-close-button.close-icon {
              display: none;
              color: red;
            }
            tab-label-container {
              color: ${colors.base00};
            }
            #_c607c8df-14a7-4f28-894f-29e8722976af_-BAP {
               color: ${colors.base00};
            }
            #TabsToolbar {
              background-color: ${colors.base00} !important;
            }
            #nav-bar {
              background-color: ${colors.base00};
            }
            #tracking-protection-icon-container {
              background-color: ${colors.base00};
            }
            #appMenu-multiView {
              background-color: ${colors.base00} !important;
            }
            .urlbar-page-action {
              background-color: ${colors.base00};
            }
            .identity-box-button  {
              background-color: ${colors.base00};
            }
            .urlbar-input-box {
              background-color: ${colors.base00};
            }
            #sidebar-main {
              background-color: ${colors.base00} !important;
            }
            .tabbrowser-tab {
              color: ${colors.base05} !important;
              color-scheme: unset;
            }
            tab[selected="true"] > .tab-stack > .tab-background {
              background: ${colors.base01} !important;
            }
            tab:not([selected="true"]) > .tab-stack:hover > .tab-background {
              background: ${colors.base01} !important;
            }
            #firefox-view-button {
              list-style-image : url(nix-snowflake.svg) !important;
            }
          '';
        };
      };
    };
  };
}
