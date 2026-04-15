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
  colors = config.lib.stylix.colors.withHashtag;
in
{
  programs.nvf.settings.vim = {
    extraPackages = with pkgs; [
      fd
      imagemagick
    ];
    extraPlugins = {
      snipe = {
        package = pkgs.vimPlugins.snipe-nvim;
        setup = "require('snipe').setup()";
      };
    };
    visuals = {
      nvim-web-devicons.enable = true;
      # rainbow-delimiters.enable = true;
    };
    theme = {
      enable = true;
      name = "base16";
      base16-colors.base00 = "${colors.base00}";
      base16-colors.base01 = "${colors.base01}";
      base16-colors.base02 = "${colors.base02}";
      base16-colors.base03 = "${colors.base03}";
      base16-colors.base04 = "${colors.base04}";
      base16-colors.base05 = "${colors.base05}";
      base16-colors.base06 = "${colors.base06}";
      base16-colors.base07 = "${colors.base07}";
      base16-colors.base08 = "${colors.base08}";
      base16-colors.base09 = "${colors.base09}";
      base16-colors.base0A = "${colors.base0A}";
      base16-colors.base0B = "${colors.base0B}";
      base16-colors.base0C = "${colors.base0C}";
      base16-colors.base0D = "${colors.base0D}";
      base16-colors.base0E = "${colors.base0E}";
      base16-colors.base0F = "${colors.base0F}";
      extraConfig = ''
           -- Brackets/delimiters → neutral gray
        vim.api.nvim_set_hl(0, "Delimiter", { fg = "${colors.base05}" })
        vim.api.nvim_set_hl(0, "@punctuation", { fg = "${colors.base05}" })
        vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "${colors.base05}" })
        vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = "${colors.base05}" })
        vim.api.nvim_set_hl(0, "@punctuation.special", { fg = "${colors.base05}" })

        -- Comments → bump contrast slightly
        vim.api.nvim_set_hl(0, "Comment", { fg = "${colors.base04}" })
        vim.api.nvim_set_hl(0, "@comment", { fg = "${colors.base04}" })      '';
    };
    telescope.enable = true;
    snippets = {
      luasnip.enable = true;
    };
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;

      setupOpts = {
        keymap = {
          "<A-y>" = [
            (lib.generators.mkLuaInline ''
              function(cmp)
                cmp.show { providers = { 'minuet' } }
              end
            '')
          ];
        };
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];

          providers = {
            minuet = {
              name = "minuet";
              module = "minuet.blink";
              async = true;
              #Should match minuet.config.request_timeout * 1000,
              #since minuet.config.request_timeout is in seconds
              timeout_ms = 3000;
              score_offset = 50;
            };
          };
        };
        snippets = {
          preset = "luasnip";
        };
        completion = {
          ghost_text = {
            enabled = true;
          };
          trigger = {
            prefetch_on_insert = false;
          };
        };
        appearance = {
          kind_icons = {
            Ollama = "󰳆";
          };
        };
      };
      mappings = {
        close = "<C-e>";
        confirm = "<C-y>";
      };
    };

    git = {
      gitsigns.enable = true;
    };
    terminal = {
      toggleterm = {
        enable = true;
      };
    };
    autopairs = {
      nvim-autopairs.enable = true;
    };
  };
}
