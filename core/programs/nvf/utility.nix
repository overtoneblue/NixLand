{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
{
  hm.programs.nvf.settings.vim.utility = {
    preview = {
      markdownPreview = {
        enable = true;
      };
    };
    outline.aerial-nvim = {
      enable = true;
    };
    vim-wakatime = {
      enable = true;
      cli-package = pkgs.wakatime-cli;
    };
    snacks-nvim = {
      enable = true;
      setupOpts = {
        explorer = {
          replace_netrw = true;
        };
        picker = {
          layout = {
            preset = "telescope";
          };
          # preview = true;
          sources = {
            explorer = {
              jump = {
                close = true;
              };
              # auto_close = true;
              layout = {
                preset = "telescope";
                preview = true;
              };
            };
          };
        };
        input = {
          enabled = true;
        };
        notifier = {
          enabled = true;
        };
        statuscolumn = {
          enabled = true;
        };
        scroll = {
          enabled = true;
        };
        image = {
          enabled = true;
          doc = {
            float = true;
            max_width = 20;
            max_height = 10;
          };
        };
      };
    };
  };
}
