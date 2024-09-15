{ ... }:
{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      undo.enable = true;
    };
    enabledExtensions = [
      "zoxide"
      "noice"
    ];
    settings = {
      pickers = {
        colorscheme.enable_preview = true;
      };
      defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
          "^secrets/"
        ];
        mappings = {
          n = {
            q = {
              __raw = "require('telescope.actions').close";
            };
            s = {
              __raw = "require('telescope.actions').select_horizontal";
            };
            v = {
              __raw = "require('telescope.actions').select_vertical";
            };
          };
        };
      };
      extensions = {
        media_files = {
          filetypes = [
            "png"
            "webp"
            "jpg"
            "jpeg"
            "mp4"
            "pdf"
            "webm"
          ];
          find_cmd = "rg";
        };
        zoxide = {
          mappings = {
            default = {
              keepinsert = true;
              action = {
                __raw = ''
                  function(selection)
                    require("telescope.builtin").find_files({ cwd = selection.path })
                  end'';
              };
            };
          };
        };
      };
    };
  };
}
