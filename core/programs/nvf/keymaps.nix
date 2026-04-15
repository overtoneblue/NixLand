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
  mkKeymap = mode: key: action: desc: {
    inherit
      mode
      key
      action
      desc
      ;
  };
in
{
  programs.nvf.settings.vim = {
    binds.whichKey = {
      enable = true;
      register = {
        "<leader>f" = " Picker";
        "<leader>g" = " Git";
        "<leader>t" = " Terminal";
        "<leader>l" = " LSP";
        "<leader>c" = " Spellcheck";
        "<leader>cl" = "󰗊 Language";
        "<leader>o" = " Obsidian";
        "<leader>d" = "Debug";
        "<leader>h" = "";
      };
      setupOpts = {
        preset = "classic";
        delay = 0;
        icons = {
          mappings = false;
          separator = "➜";
          group = "";
        };
        # win.border = "none";
        triggers = [
          {
            "@" = "<leader>";
            mode = "n";
          }
        ];
      };
    };

    keymaps = [
      (mkKeymap "n" "<leader>w" "<cmd>w<cr>" "Save Buffer")
      (mkKeymap "n" "<leader>q" "<cmd>q<cr>" "Quit")
      (mkKeymap "n" "<leader>e" "<cmd>lua require('snacks').explorer()<cr>" "Explorer")
      # (mkKeymap "n" "<leader>e" ":Neotree action=focus reveal toggle<cr>" "Toggle Neotree")
      (mkKeymap "n" "<leader>c" ":bdelete!<CR>" "Close Buffer")
      (mkKeymap "n" "gb" "<cmd>lua require('snipe').open_buffer_menu()<cr>" "Snipe Buffers")
      # Telescope
      # (mkKeymap "n" "<leader>ff" "<cmd>Telescope find_files<cr>" "Find File")
      # (mkKeymap "n" "<leader>fr" "<cmd>Telescope oldfiles<cr>" "Open Recent File")
      # (mkKeymap "n" "<leader>fn" "<cmd>enew<cr>" "New File")
      # (mkKeymap "n" "<leader>fw" "<cmd>Telescope live_grep<cr>" "Grep Files")
      # (mkKeymap "n" "<leader>fb" "<cmd>Telescope buffers<cr>" "Grep Buffers")
      # (mkKeymap "n" "<leader>fh" "<cmd>Telescope help_tags<cr>" "Grep Help Tags")
      # (mkKeymap "n" "<leader>fd" "<cmd>Telescope diagnostics<cr>" "Grep Diagnostics")
      # (mkKeymap "n" "<leader>fg" "<cmd>Telescope git_files<cr>" "Grep Git Files")

      # Snacks Picker Replaces Telescope!?
      (mkKeymap "n" "<leader>ff" "<cmd>lua require('snacks').picker.files()<cr>" "Find File")
      (mkKeymap "n" "<leader>fr" "<cmd>lua require('snacks').picker.recent()<cr>" "Open Recent File")
      (mkKeymap "n" "<leader>fn" "<cmd>enew<cr>" "New File")
      (mkKeymap "n" "<leader>fw" "<cmd>lua require('snacks').picker.grep()<cr>" "Grep Files")
      (mkKeymap "n" "<leader>fb" "<cmd>lua require('snacks').picker.buffers()<cr>" "Grep Buffers")
      (mkKeymap "n" "<leader>fh" "<cmd>lua require('snacks').picker.help()<cr>" "Grep Help Tags")
      (mkKeymap "n" "<leader>fg" "<cmd>lua require('snacks').picker.git_files()<cr>" "Grep Git Files")
      (mkKeymap "n" "<leader>fd" "<cmd>lua require('snacks').picker.diagnostics()<cr>" "Grep Diagnostics")
      (mkKeymap "n" "<leader>fc" "<cmd>lua require('aerial').snacks_picker()<cr>" "Code Outline")
      # Terminal
      (mkKeymap "n" "<leader>tt" "<cmd>ToggleTerm<cr>" "Toggle Terminal")
      (mkKeymap "n" "<leader>tf" "<cmd>ToggleTerm direction=float<cr>" "Toggle Float Terminal")
      (mkKeymap "t" "<Esc>" "<C-\\><C-N>" "Exit Insert Mode")

      # Git
      (mkKeymap "n" "<leader>gl" "<cmd>Gitsigns blame_line<cr>" "View Git Blame")
      (mkKeymap "n" "<leader>gL" "<cmd>Gitsigns blame_line {full = true}<cr>" "View full Git Blame")
      (mkKeymap "n" "<leader>gp" "<cmd>Gitsigns preview_hunk<cr>" "Preview Git Hunk")
      (mkKeymap "n" "<leader>gh" "<cmd>Gitsigns reset_hunk<cr>" "Reset Git Hunk")
      (mkKeymap "n" "<leader>gr" "<cmd>Gitsigns reset_buffer<cr>" "Reset Git Buffer")
      (mkKeymap "n" "<leader>gs" "<cmd>Gitsigns stage_hunk<cr>" "Stage Git Hunk")
      (mkKeymap "n" "<leader>gS" "<cmd>Gitsigns stage_buffer<cr>" "Stage Git Buffer")
      (mkKeymap "n" "<leader>gu" "<cmd>Gitsigns undo_stage_hunk<cr>" "Unstage Git Hunk")
      (mkKeymap "n" "<leader>gd" "<cmd>Gitsigns diffthis<cr>" "View Git Diff")

      #LSP
      (mkKeymap "n" "<leader>li" "<cmd>LspInfo<cr>" "LSP Information")
      (mkKeymap "n" "<leader>lI" "<cmd>NullLsInfo<cr>" "Null-ls Information")
      (mkKeymap "n" "<leader>la" "<cmd>lua vim.lsp.buf.code_action()<cr>" "LSP Code Action")
      (mkKeymap "n" "<leader>lh" "<cmd>lua vim.lsp.buf.signature_help()<cr>" "Signature Help")
      (mkKeymap "n" "<leader>lr" "<cmd>lua vim.lsp.buf.rename()<cr>" "Rename Current Symbol")
      (mkKeymap "n" "<leader>ll" "<cmd>lua vim.lsp.codelens.refresh()<cr>" "LSP CodeLens Refresh")
      (mkKeymap "n" "<leader>lL" "<cmd>lua vim.lsp.codelens.run()<cr>" "LSP CodeLens Run")
      (mkKeymap "n" "<leader>lR" "<cmd>Telescope lsp_references<cr>" "Search References")

      #Goto Bindings
      (mkKeymap "n" "gd" "<cmd>Telescope lsp_definitions<cr>" "Goto Definition")
      (mkKeymap "n" "gI" "<cmd>Telescope lsp_implementations<cr>" "Goto Implementation")
      (mkKeymap "n" "gr" "<cmd>Telescope lsp_references<cr>" "Search References")
      (mkKeymap "n" "gl" "<cmd>lua vim.diagnostic.open_float()<CR>" "Hover Diagnostics")
      (mkKeymap "n" "gy" "<cmd>Telescope lsp_type_definitions<cr>" "Definition of Current Type")

      #Buffer Nav
      (mkKeymap "n" "<S-h>" "<cmd>BufferLineCyclePrev<cr>" "Left Buffer")
      (mkKeymap "n" "<S-l>" "<cmd>BufferLineCycleNext<cr>" "Right Buffer")
      (mkKeymap "n" "K" "<cmd>lua vim.lsp.buf.hover()<cr>" "Hover Symbol Details")
    ];
  };
}
