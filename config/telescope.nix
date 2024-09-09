{ mkKey, ... }:
let inherit (mkKey) mkKeymap;
in {
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      undo.enable = true;
    };
    enabledExtensions = [ "zoxide" "noice"];
    settings = {
      pickers = { colorscheme.enable_preview = true; };
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
            q = { __raw = "require('telescope.actions').close"; };
            s = { __raw = "require('telescope.actions').select_horizontal"; };
            v = { __raw = "require('telescope.actions').select_vertical"; };
          };
        };
      };
      extensions = {
        media_files = {
          filetypes = [ "png" "webp" "jpg" "jpeg" "mp4" "pdf" "webm" ];
          find_cmd = "rg";
        };
        zoxide = {
          mappings = {
            default = {
              keepinsert = true;
              action = {__raw = ''
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
  keymaps = [
    (mkKeymap "n" "<leader>go" "<cmd>Telescope git_status<cr>"
      "Open changed file")
    (mkKeymap "n" "<leader>gb" "<cmd>Telescope git_branches<cr>"
      "Checkout branch")
    (mkKeymap "n" "<leader>gc" "<cmd>Telescope git_commits<cr>"
      "Checkout commit")

    (mkKeymap "n" "<leader>td" "<cmd>Telescope diagnostics theme=ivy<cr>"
      "Search Diagnostics")
    (mkKeymap "n" "<leader>tn" "<cmd>Telescope notify<cr>"
      "Notifications Search")
    (mkKeymap "n" "<leader>tf" "<cmd>Telescope find_files<cr>"
      "Search Find files")
    (mkKeymap "n" "<leader>tF" "<cmd>Telescope find_files hidden=true<cr>"
      "Find files Hidden Also")
    (mkKeymap "n" "<leader>tr" "<cmd>Telescope oldfiles<cr>"
      "Search Recent files")
    (mkKeymap "n" "<leader>tk" "<cmd>Telescope keymaps theme=dropdown<cr>"
      "Search Keymaps")
    (mkKeymap "n" "<leader>tn" "<cmd>Noice telescope<cr>"
      "Search Notifications")
    (mkKeymap "n" "<leader>ts" "<cmd>Telescope builtin<cr>" "Search Telescope")
    (mkKeymap "n" "<leader>tg" "<cmd>Telescope live_grep<cr>"
      "Search Live Grep")
    (mkKeymap "n" "<leader>tH" "<cmd>Telescope help_tags<cr>"
      "Search Help Tags")
    (mkKeymap "n" "<leader>tb" "<cmd>Telescope buffers<cr>" "Search Buffers")
    (mkKeymap "n" "<leader>tc" "<cmd>Telescope commands<cr>" "Search Commands")
    (mkKeymap "n" "<leader>tm" "<cmd>Telescope marks<cr>"
      "Search in Media Mode")
    (mkKeymap "n" "<leader>to" "<cmd>Telescope vim_options<cr>"
      "Search Vim Options")
    (mkKeymap "n" "<leader>tq" "<cmd>Telescope quickfix<cr>" "Search Quickfix")
    (mkKeymap "n" "<leader>tl" "<cmd>Telescope loclist<cr>"
      "Search Location List")
    (mkKeymap "n" "<leader>tP" "<cmd>Telescope colorscheme<cr>"
      "Search ColorScheme with previews")
    (mkKeymap "n" "<leader>tu" "<cmd>Telescope undo<cr>" "Search undo")
    (mkKeymap "n" "<leader>tz" "<cmd>Telescope zoxide list<cr>" "Search zoxide")
    (mkKeymap "n" "<leader>t/" "<cmd>Telescope current_buffer_fuzzy_find<cr>"
      "Fuzzy Buffer Search")

  ];
}
