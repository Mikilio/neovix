{
  lib,
  pkgs,
  inputs,
  ...
}: {
  plugins = {
    noice = {
      enable = true;
      lazyLoad.settings.event = ["DeferredUIEnter"];
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
    web-devicons.enable = true;

    colorizer = {
      enable = true;
      lazyLoad.settings.event = "BufReadPre";
    };

    lz-n.plugins = [
      {
        __unkeyed-1 = "tinted-nvim";
        colorscheme = true;
        after =
          # lua
          ''
            function()
              require('tinted-colorscheme').setup(vim.g.colors_name)
            end
          '';
      }
    ];
  };
  colorscheme = lib.mkDefault "base16-catppuccin-mocha";
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "tinted-nvim";
      src = inputs.tinted-nvim;
    })
  ];
}
