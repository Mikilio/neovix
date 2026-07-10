{ lib
, pkgs
, ...
}: {
  enableMan = true;
  viAlias = true;
  vimAlias = true;

  clipboard.providers.wl-copy.enable = true;

  globals.mapleader = " ";

  globalOpts.statusline = "%#Normal#";

  plugins.lz-n.enable = true;

  opts = {
    clipboard = "unnamedplus";
    cursorline = true;

    pumblend = 0;
    pumheight = 10;

    expandtab = true;
    shiftwidth = 2;
    smartindent = true;
    tabstop = 2;
    softtabstop = 2;

    ignorecase = true;
    smartcase = true;
    mouse = "a";
    cmdheight = 0;

    signcolumn = "yes";
    splitbelow = true;
    splitright = true;
    splitkeep = "screen";
    termguicolors = true;
    timeoutlen = lib.mkDefault 400;

    conceallevel = 2;

    undofile = true;

    wrap = false;

    virtualedit = "block";
    fileencoding = "utf-8";
    list = true;
    smoothscroll = true;
    scrolloff = 2;
    fillchars = {
      eob = " ";
    };

    #interval for writing swap file to disk, also used by gitsigns
    updatetime = 550;

    winwidth = 20;
    winminwidth = 20;
    equalalways = false;
  };

  # NOTE: coreutils/gzip/util-linux were previously listed here but are
  # present in virtually all environments. Re-add if you run this via
  # `nix run` on a host that lacks them.

  keymaps = [
    # Misc
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
