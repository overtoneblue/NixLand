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
  programs.nvf.settings.vim = {
    statusline.lualine = {
      enable = true;
      theme = "base16";
      componentSeparator = {
        right = "";
        left = "";
      };
      sectionSeparator = {
        right = "";
        left = "";
      };
      setupOpts = {
        icons_enabled = true;
        disabled_filetypes = {
          statusline = [ ];
          winbar = [ ];
        };
        ignore_focus = [ ];
        always_divide_middle = true;
        globalstatus = false;
        refresh = {
          statusline = 1000;
          tabline = 1000;
          winbar = 1000;
        };
      };

      # Active sections: we use the built-in "mode" component (which will use our custom mapping)
      activeSection.a = [
        "{
            (function()
             local mode_map = {
               ['n']   = '',
               ['no']  = '',
               ['nov'] = '',
               ['noV'] = '',
               ['no�'] = '',
               ['niI'] = '',
               ['niR'] = '',
               ['niV'] = '',
               ['nt']  = '',
               ['v']   = '',
               ['vs']  = '',
               ['V']   = '',
               ['Vs']  = '',
               ['�']   = '',
               ['�s']  = '',
               ['s']   = '',
               ['S']   = '',
               ['�']   = '',
               ['i']   = '',
               ['ic']  = '',
               ['ix']  = '',
               ['R']   = '',
               ['Rc']  = '',
               ['Rx']  = '',
               ['Rv']  = '',
               ['Rvc'] = '',
               ['Rvx'] = '',
               ['c']   = '',
               ['cv']  = '',
               ['ce']  = '',
               ['r']   = '',
               ['rm']  = '',
               ['r?']  = '',
               ['!']   = '',
               ['t']   = '',
             }
             return function()
               return mode_map[vim.api.nvim_get_mode().mode] or '__'
             end
          end)(),
          separator = { left = '' },
          right_padding = 2
        }"
      ];
      activeSection.b = [
        ''
          {
            "branch",
            icon = ' •',
            separator = { right = ''},
          }
        ''
      ];
      activeSection.c = [
        ''
          {
            "filename",
            icon = '',
          }
        ''
      ];
      activeSection.x = [ ];
      activeSection.y = [ ];
      activeSection.z = [ ];

      # Inactive sections
      inactiveSection.a = [ ];
      inactiveSection.b = [ ];
      inactiveSection.c = [ "'filename'" ];
      inactiveSection.x = [ "'location'" ];
      inactiveSection.y = [ ];
      inactiveSection.z = [ ];
    };

  };
}
