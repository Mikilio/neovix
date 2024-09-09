{ mkKey, ... }:
let
  inherit (mkKey) mkKeymap mkKeymap' mkKeymapWithOpts;
  insert = [
    (mkKeymap "i" "<a-j>" "<esc>:m .+1<cr>==gi" "Move Line Down")
    (mkKeymap "i" "<a-k>" "<esc>:m .-2<cr>==gi" "Move Line Up")
  ];
  normal = [

    # Resizing
    (mkKeymap "n" "<A-Left>" {
      __raw = ''function() require('smart-splits').resize_left() end'';
    } "Resize Left")
    (mkKeymap "n" "<A-Down>" {
      __raw = ''function() require('smart-splits').resize_down() end'';
    } "Resize Down")
    (mkKeymap "n" "<A-Up>" {
      __raw = ''function() require('smart-splits').resize_up() end'';
    } "Resize Up")
    (mkKeymap "n" "<A-Right>" {
      __raw = ''function() require('smart-splits').resize_right() end'';
    } "Resize Right")

    # Window movement
    (mkKeymap "n" "<C-Left>" {
      __raw = ''function() require('smart-splits').move_cursor_left() end'';
    } "Move Left")
    (mkKeymap "n" "<C-Down>" {
      __raw = ''function() require('smart-splits').move_cursor_down() end'';
    } "Move Down")
    (mkKeymap "n" "<C-Up>" {
      __raw = ''function() require('smart-splits').move_cursor_up() end'';
    } "Move Up")
    (mkKeymap "n" "<C-Right>" {
      __raw = ''function() require('smart-splits').move_cursor_right() end'';
    } "Move Down")

    # Swapping windows
    (mkKeymap "n" "<C-S-Down>" "<C-W>J" "Swap Down")
    (mkKeymap "n" "<C-S-Left>" "<C-W>H" "Swap Left")
    (mkKeymap "n" "<C-S-Right>" "<C-W>L" "Swap Right")
    (mkKeymap "n" "<C-S-Up>" "<C-W>K" "Swap Up")

    #Splitting windows
    (mkKeymap "n" "<leader>w<Down>" ":set splitbelow<CR>:split<CR>" "New Window down")
    (mkKeymap "n" "<leader>w<Left>" ":set nosplitright<CR>:vsplit<CR>" "New Window left")
    (mkKeymap "n" "<leader>w<Right>" ":set splitright<CR>:vsplit<CR>" "New Window right")
    (mkKeymap "n" "<leader>w<Up>" ":set nosplitbelow<CR>:split<CR>" "New Window up")
    (mkKeymap "n" "<leader>wz" ":WindowsMaximize" "Maximize Window")
    (mkKeymap "n" "<leader>w_" ":WindowsMaximizeVertically" "Maximize Window Vertically")
    (mkKeymap "n" "<leader>w|" ":WindowsMaximizeHorizontally" "Maximize Window Horizintally")
    (mkKeymap "n" "<leader>w=" ":WindowsEqualize" "Adjust window size")
    (mkKeymap "n" "<leader>wx" ":close<CR>" "Close current Window")

    (mkKeymap "n" "<leader>ex" ":Explore<CR>" "Open Netrw")

    (mkKeymap "n" "<s-Down>" "<cmd>m .+1<cr>==" "Move line Down")
    (mkKeymap "n" "<s-Up>" "<cmd>m .-2<cr>==" "Move line Up")

    (mkKeymap "n" "<leader>ft" {
      __raw = ''
        function()
          vim.ui.input({ prompt = "Enter FileType: " }, function(input)
            local ft = input
            if not input or input == "" then
              ft = vim.bo.filetype
            end
            vim.o.filetype = ft
          end)
        end
      '';
    } "Set Filetype")

    (mkKeymap "n" "n" "nzzzv" "Move to center")
    (mkKeymap "n" "N" "Nzzzv" "Moving to center")
    (mkKeymap "n" "x" ''"_x'' "No Copy Delete")
    (mkKeymap "n" "r" ''"_r'' "No Copy Change")
  ];
  v = [

    (mkKeymap "v" "<s-Down>" ":m '>+1<cr>gv-gv" "Move Selected Line Down")
    (mkKeymap "v" "<s-Up>" ":m '<lt>-2<CR>gv-gv" "Move Selected Line Up")

    (mkKeymap "v" "<" "<gv" "Indent out")
    (mkKeymap "v" ">" ">gv" "Indent in")

    (mkKeymap "v" "<space>" "<Nop>" "Mapped to Nothing")

    (mkKeymap "v" "x" ''"_x'' "No Copy Delete")
    (mkKeymap "v" "P" ''"_dP'' "No Copy Paste Above")

    (mkKeymap "v" "<leader>y" ''"+y'' "Register Y")
    (mkKeymap "v" "<leader>d" ''"+d'' "Register d")
    (mkKeymap "v" "<leader>Y" ''gg"+yG'' "Register Y")
    (mkKeymap "v" "<leader>D" ''gg"+dG'' "Register D")
    (mkKeymap "v" "<leader>x" ''"+x'' "Register x")
    (mkKeymap "v" "<leader>X" ''"+'' "Register X")

  ];
  xv = [
    (mkKeymap "x" "p" ''p:let @+=@0<CR>:let @"=@0<CR>'' "Dont copy replaced text")
  ];
in
{
  keymaps = insert ++ normal ++ v ++ xv;
  plugins.smart-splits.enable = true;
}
