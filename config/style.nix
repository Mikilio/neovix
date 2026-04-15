{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  extraConfigLuaPre =
    #lua
    ''
      local function source_matugen()
        -- Update this with the location of your output file
        local matugen_path = os.getenv("HOME") .. "/.config/nvim/generated.lua"  -- dofile doesn't expand $HOME or ~

        local file, err = io.open(matugen_path, "r")
        -- If the matugen file does not exist (yet or at all), we must initialize a color scheme ourselves
        if err ~= nil then
          -- Some placeholder theme, this will be overwritten once matugen kicks in
          vim.cmd('colorscheme base16-catppuccin-mocha')

          -- Optionally print something to the user
          vim.print("A matugen style file was not found, but that's okay! The colorscheme will dynamically change if matugen runs!")
        else
          dofile(matugen_path)
          io.close(file)
        end
      end

      local function auxiliary_function()
        -- Load the matugen style file to get all the new colors
        source_matugen()
        require('lz.n').trigger_load('lualine')
      end

      source_matugen()
    '';

  autoCmd = [
    {
      event = "Signal";
      pattern = "SIGUSR1";
      callback.__raw = "auxiliary_function";
    }
  ];

  colorschemes.base16 = {
    enable = true;
  };

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
}
