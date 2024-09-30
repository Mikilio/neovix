{ ... }:
{
  plugins.smart-splits.enable = true;
  keymaps = [
    # Integrations
    {
      action = {
        __raw = "function() require('yazi').yazi() end";
      };
      key = "<leader>ya";
      mode = "";
      options = {
        desc = "Open Yazi";
      };
    }
    {
      key = "<leader>mp";
      action = ":MarkdownPreviewToggle<CR>";
      options.desc = "Toggle Markdown Preview";
    }
    {
      action = {
        __raw = "function() require('flash').jump() end";
      };
      key = "s";
      mode = [
        "n"
        "x"
        "o"
      ];
      options = {
        desc = "Flash";
        noremap = true;
      };
    }

    # Flash
    {
      action = {
        __raw = "function() require('flash').treesitter() end";
      };
      key = "S";
      mode = [
        "n"
        "x"
        "o"
      ];
      options = {
        desc = "Flash Treesitter";
        noremap = true;
      };
    }
    {
      action = {
        __raw = "function() require('flash').remote() end";
      };
      key = "r";
      mode = [ "o" ];
      options = {
        desc = "Remote Flash";
        noremap = true;
      };
    }
    {
      action = {
        __raw = "function() require('flash').treesitter_search() end";
      };
      key = "R";
      mode = [
        "o"
        "x"
      ];
      options = {
        desc = "Treesitter Search";
        noremap = true;
      };
    }
    {
      action = {
        __raw = "function() require('flash').toggle() end";
      };
      key = "<c-s>";
      mode = [ "c" ];
      options = {
        desc = "Toggle Flash Search";
        noremap = true;
      };
    }

    #Git
    {
      action = "<cmd>lua require 'gitsigns'.next_hunk()<cr>";
      key = "]g";
      mode = "n";
      options = {
        desc = "Next Hunk";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>lua require 'gitsigns'.prev_hunk()<cr>";
      key = "[g";
      mode = "n";
      options = {
        desc = "Prev Hunk";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>lua require 'gitsigns'.blame_line()<cr>";
      key = "<leader>gl";
      mode = "n";
      options = {
        desc = "Blame";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>lua require 'gitsigns'.preview_hunk()<cr>";
      key = "<leader>gp";
      mode = "n";
      options = {
        desc = "Preview Hunk";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>lua require 'gitsigns'.reset_hunk()<cr>";
      key = "<leader>gr";
      mode = "n";
      options = {
        desc = "Reset Hunk";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>lua require 'gitsigns'.reset_buffer()<cr>";
      key = "<leader>gR";
      mode = "n";
      options = {
        desc = "Reset Buffer";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>lua require 'gitsigns'.stage_hunk()<cr>";
      key = "<leader>gs";
      mode = "n";
      options = {
        desc = "Stage Hunk";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>";
      key = "<leader>gu";
      mode = "n";
      options = {
        desc = "Undo Stage Hunk";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Gitsigns diffthis HEAD<cr>";
      key = "<leader>gd";
      mode = "n";
      options = {
        desc = "Diff";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>lua require 'gitsigns'.stage_hunk({vim.fn.line('.'),vim.fn.line('v')})<cr>";
      key = "<leader>gs";
      mode = "v";
      options = {
        desc = "Stage Hunk";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>lua require 'gitsigns'.undo_stage_hunk({vim.fn.line('.'),vim.fn.line('v')})<cr>";
      key = "<leader>gu";
      mode = "v";
      options = {
        desc = "Undo Hunk";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>lua require 'gitsigns'.reset_hunk({vim.fn.line('.'),vim.fn.line('v')})<cr>";
      key = "<leader>gr";
      mode = "v";
      options = {
        desc = "Reset Hunk";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope git_status<cr>";
      key = "<leader>go";
      mode = "n";
      options = {
        desc = "Open changed file";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope git_branches<cr>";
      key = "<leader>gb";
      mode = "n";
      options = {
        desc = "Checkout branch";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope git_commits<cr>";
      key = "<leader>gc";
      mode = "n";
      options = {
        desc = "Checkout commit";
        noremap = true;
        silent = true;
      };
    }
    
    # Telescope
    {
      action = "<cmd>Telescope diagnostics theme=ivy<cr>";
      key = "<leader>td";
      mode = "n";
      options = {
        desc = "Search Diagnostics";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope notify<cr>";
      key = "<leader>tn";
      mode = "n";
      options = {
        desc = "Notifications Search";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope find_files<cr>";
      key = "<leader>tf";
      mode = "n";
      options = {
        desc = "Search Find files";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope find_files hidden=true<cr>";
      key = "<leader>tF";
      mode = "n";
      options = {
        desc = "Find files Hidden Also";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope oldfiles<cr>";
      key = "<leader>tr";
      mode = "n";
      options = {
        desc = "Search Recent files";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope keymaps theme=dropdown<cr>";
      key = "<leader>tk";
      mode = "n";
      options = {
        desc = "Search Keymaps";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Noice telescope<cr>";
      key = "<leader>tn";
      mode = "n";
      options = {
        desc = "Search Notifications";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope builtin<cr>";
      key = "<leader>ts";
      mode = "n";
      options = {
        desc = "Search Telescope";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope live_grep<cr>";
      key = "<leader>tg";
      mode = "n";
      options = {
        desc = "Search Live Grep";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope help_tags<cr>";
      key = "<leader>tH";
      mode = "n";
      options = {
        desc = "Search Help Tags";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope buffers<cr>";
      key = "<leader>tb";
      mode = "n";
      options = {
        desc = "Search Buffers";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope commands<cr>";
      key = "<leader>tc";
      mode = "n";
      options = {
        desc = "Search Commands";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope marks<cr>";
      key = "<leader>tm";
      mode = "n";
      options = {
        desc = "Search in Media Mode";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope vim_options<cr>";
      key = "<leader>to";
      mode = "n";
      options = {
        desc = "Search Vim Options";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope quickfix<cr>";
      key = "<leader>tq";
      mode = "n";
      options = {
        desc = "Search Quickfix";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope loclist<cr>";
      key = "<leader>tl";
      mode = "n";
      options = {
        desc = "Search Location List";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope colorscheme<cr>";
      key = "<leader>tP";
      mode = "n";
      options = {
        desc = "Search ColorScheme with previews";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope undo<cr>";
      key = "<leader>tu";
      mode = "n";
      options = {
        desc = "Search undo";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope zoxide list<cr>";
      key = "<leader>tz";
      mode = "n";
      options = {
        desc = "Search zoxide";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
      key = "<leader>t/";
      mode = "n";
      options = {
        desc = "Fuzzy Buffer Search";
        noremap = true;
        silent = true;
      };
    }

    #Smart Splits
    {
      action = {
        __raw = "function() require('smart-splits').resize_left() end";
      };
      key = "<A-Left>";
      mode = "n";
      options = {
        desc = "Resize Left";
        noremap = true;
        silent = true;
      };
    }
    {
      action = {
        __raw = "function() require('smart-splits').resize_down() end";
      };
      key = "<A-Down>";
      mode = "n";
      options = {
        desc = "Resize Down";
        noremap = true;
        silent = true;
      };
    }
    {
      action = {
        __raw = "function() require('smart-splits').resize_up() end";
      };
      key = "<A-Up>";
      mode = "n";
      options = {
        desc = "Resize Up";
        noremap = true;
        silent = true;
      };
    }
    {
      action = {
        __raw = "function() require('smart-splits').resize_right() end";
      };
      key = "<A-Right>";
      mode = "n";
      options = {
        desc = "Resize Right";
        noremap = true;
        silent = true;
      };
    }
    {
      action = {
        __raw = "function() require('smart-splits').move_cursor_left() end";
      };
      key = "<C-Left>";
      mode = "n";
      options = {
        desc = "Move Left";
        noremap = true;
        silent = true;
      };
    }
    {
      action = {
        __raw = "function() require('smart-splits').move_cursor_down() end";
      };
      key = "<C-Down>";
      mode = "n";
      options = {
        desc = "Move Down";
        noremap = true;
        silent = true;
      };
    }
    {
      action = {
        __raw = "function() require('smart-splits').move_cursor_up() end";
      };
      key = "<C-Up>";
      mode = "n";
      options = {
        desc = "Move Up";
        noremap = true;
        silent = true;
      };
    }
    {
      action = {
        __raw = "function() require('smart-splits').move_cursor_right() end";
      };
      key = "<C-Right>";
      mode = "n";
      options = {
        desc = "Move Down";
        noremap = true;
        silent = true;
      };
    }

    # Window Management
    {
      action = "<C-W>J";
      key = "<C-S-Down>";
      mode = "n";
      options = {
        desc = "Swap Down";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<C-W>H";
      key = "<C-S-Left>";
      mode = "n";
      options = {
        desc = "Swap Left";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<C-W>L";
      key = "<C-S-Right>";
      mode = "n";
      options = {
        desc = "Swap Right";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<C-W>K";
      key = "<C-S-Up>";
      mode = "n";
      options = {
        desc = "Swap Up";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":set splitbelow<CR>:split<CR>";
      key = "<leader>w<Down>";
      mode = "n";
      options = {
        desc = "New Window down";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":set nosplitright<CR>:vsplit<CR>";
      key = "<leader>w<Left>";
      mode = "n";
      options = {
        desc = "New Window left";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":set splitright<CR>:vsplit<CR>";
      key = "<leader>w<Right>";
      mode = "n";
      options = {
        desc = "New Window right";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":set nosplitbelow<CR>:split<CR>";
      key = "<leader>w<Up>";
      mode = "n";
      options = {
        desc = "New Window up";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":WindowsMaximize";
      key = "<leader>wz";
      mode = "n";
      options = {
        desc = "Maximize Window";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":WindowsMaximizeVertically";
      key = "<leader>w_";
      mode = "n";
      options = {
        desc = "Maximize Window Vertically";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":WindowsMaximizeHorizontally";
      key = "<leader>w|";
      mode = "n";
      options = {
        desc = "Maximize Window Horizintally";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":WindowsEqualize";
      key = "<leader>w=";
      mode = "n";
      options = {
        desc = "Adjust window size";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":close<CR>";
      key = "<leader>wx";
      mode = "n";
      options = {
        desc = "Close current Window";
        noremap = true;
        silent = true;
      };
    }

    # Misc
    {
      action = "<cmd>m .+1<cr>==";
      key = "<s-Down>";
      mode = "n";
      options = {
        desc = "Move line Down";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<cmd>m .-2<cr>==";
      key = "<s-Up>";
      mode = "n";
      options = {
        desc = "Move line Up";
        noremap = true;
        silent = true;
      };
    }
    {
      action = {
        __raw = "function()\n  vim.ui.input({ prompt = \"Enter FileType: \" }, function(input)\n    local ft = input\n    if not input or input == \"\" then\n      ft = vim.bo.filetype\n    end\n    vim.o.filetype = ft\n  end)\nend\n";
      };
      key = "<leader>ft";
      mode = "n";
      options = {
        desc = "Set Filetype";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "nzzzv";
      key = "n";
      mode = "n";
      options = {
        desc = "Move to center";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "Nzzzv";
      key = "N";
      mode = "n";
      options = {
        desc = "Moving to center";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "\"_x";
      key = "x";
      mode = "n";
      options = {
        desc = "No Copy Delete";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "\"_r";
      key = "r";
      mode = "n";
      options = {
        desc = "No Copy Change";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":m '>+1<cr>gv-gv";
      key = "<s-Down>";
      mode = "v";
      options = {
        desc = "Move Selected Line Down";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ":m '<lt>-2<CR>gv-gv";
      key = "<s-Up>";
      mode = "v";
      options = {
        desc = "Move Selected Line Up";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<gv";
      key = "<";
      mode = "v";
      options = {
        desc = "Indent out";
        noremap = true;
        silent = true;
      };
    }
    {
      action = ">gv";
      key = ">";
      mode = "v";
      options = {
        desc = "Indent in";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "<Nop>";
      key = "<space>";
      mode = "v";
      options = {
        desc = "Mapped to Nothing";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "\"_x";
      key = "x";
      mode = "v";
      options = {
        desc = "No Copy Delete";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "\"_dP";
      key = "P";
      mode = "v";
      options = {
        desc = "No Copy Paste Above";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "\"+y";
      key = "<leader>y";
      mode = "v";
      options = {
        desc = "Register Y";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "\"+d";
      key = "<leader>d";
      mode = "v";
      options = {
        desc = "Register d";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "gg\"+yG";
      key = "<leader>Y";
      mode = "v";
      options = {
        desc = "Register Y";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "gg\"+dG";
      key = "<leader>D";
      mode = "v";
      options = {
        desc = "Register D";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "\"+x";
      key = "<leader>x";
      mode = "v";
      options = {
        desc = "Register x";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "\"+";
      key = "<leader>X";
      mode = "v";
      options = {
        desc = "Register X";
        noremap = true;
        silent = true;
      };
    }
    {
      action = "p:let @+=@0<CR>:let @\"=@0<CR>";
      key = "p";
      mode = "x";
      options = {
        desc = "Dont copy replaced text";
        noremap = true;
        silent = true;
      };
    }
  ];
}
