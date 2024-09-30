{
  lib,
  ...
}:
let
  rainbow = [
    "rainbowcol1"
    "rainbowcol2"
    "rainbowcol3"
    "rainbowcol4"
    "rainbowcol5"
    "rainbowcol6"
    "rainbowcol7"
  ];
in
{
  plugins = {
    noice = {
      enable = true;
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        inc_rename = true;
        lsp_doc_border = true;
      };

      notify.view = "mini";
    };

    nvim-colorizer = {
      enable = true;
      userDefaultOptions = {
        RGB = true;
        RRGGBB = true;
        names = true;
        RRGGBBAA = true;
        AARRGGBB = true;
        rgb_fn = true;
        hsl_fn = true;
        css = true;
        css_fn = true;
        mode = "background";
        tailwind = true;
        sass = {
          enable = true;
        }; # fff
        virtualtext = "■";
      };
    };

    indent-blankline = {
      enable = true;
      settings = {
        exclude = {
          buftypes = [
            "terminal"
            "nofile"
            "quickfix"
            "prompt"
          ];
          filetypes = [
            "lspinfo"
            "packer"
            "checkhealth"
            "help"
            "man"
            "dashboard"
            "gitcommit"
            "TelescopePrompt"
            "TelescopeResults"
            "''"
          ];
        };
        scope = {
          show_exact_scope = true;
          highlight = rainbow;
        };
      };
    };

    rainbow-delimiters = {
      enable = true;
      highlight = rainbow;
    };

    neoscroll.enable = true;
    todo-comments.enable = true;
    web-devicons.enable = true;
  };

  extraConfigLuaPost = # lua
    ''
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    '';

  # these optons are to be overriden by stylix
  colorschemes.base16 = {
    colorscheme = lib.mkDefault "catppuccin-mocha";
    settings.telescope_borders = true;
    enable = true;
  };
}
