# This file contains plugins that are basics or don't need their own file
{ pkgs, inputs, ... }:
let
  mkPkgs = name: src: pkgs.vimUtils.buildVimPlugin { inherit name src; };

  # ePlugins are the plugins that are not available in nixpkgs/nixvim coming from flakes
  ePlugins = [
    (mkPkgs "focus" inputs.focus)
  ];
  # nPlugins are normally available in nixpkgs
  nPlugins = with pkgs.vimPlugins; [ telescope-zoxide ];

in
{
  # Keeping this at top so that if any plugin is removed it's respective config can be removed
  extraConfigLua = # lua
    ''

      require("focus").setup({
          autoresize = {
              minwidth = 40,
              minheight = 10,
          },
          ui = {
              hybridnumber = true,
              winhighlight = true,
          },
      })
    '';

  extraPlugins = nPlugins ++ ePlugins;
  extraPackages = with pkgs; [
    curl
    gzip
    coreutils
    util-linux
  ];
}
