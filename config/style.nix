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
      settings = {
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

    snacks = {
      enable = true;
      settings = {
        bigfile.enabled = true;
        input.enabled = true;
        notifier = {
          enabled = true;
          timeout = 3500;
        };
        quickfile.enabled = true;
        statuscolumn.enabled = true;
        words.enabled = true;
        scroll.enabled = true;
      };
    };

    colorizer.enable = true;
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
