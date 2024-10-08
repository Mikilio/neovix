{ lib, ... }:
{
  enableMan = true;
  viAlias = true;
  vimAlias = true;

  clipboard.providers.wl-copy.enable = true;

  globals.mapleader = " ";

  globalOpts.statusline = "%#Normal#";
  opts = {
    clipboard = "unnamedplus";
    cursorline = true;
    cursorlineopt = "number";

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

    number = true;
    relativenumber = true;
    numberwidth = 2;

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
    fillchars = {
      eob = " ";
    };

    #interval for writing swap file to disk, also used by gitsigns
    updatetime = 550;

    winwidth = 20;
    winminwidth = 20;
    equalalways = false;
  };
}
