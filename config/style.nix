{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  
  extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
    name = "base46";
    src = pkgs.fetchFromGitHub {
        owner = "AvengeMedia";
        repo = "base46";
        rev = "cb8a1257bbc2640f6e7415a01219b34d3efd1494";
        hash = "sha256-6kK8q2dmmW3RO9FQmlcYN6Yyhl6fXE5ey1l8PWRVCfc=";
    };
    nvimRequireCheck = [];
    doCheck = false;
  })];

  extraConfigLuaPre =
    #lua
    ''
      require("base46").setup()
      vim.opt.runtimepath:append(vim.fn.expand("~/.config/nvim"))
    '';

  colorscheme = "dms";

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
  };
}
