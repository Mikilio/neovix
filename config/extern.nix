# This file contains plugins that are basics or don't need their own file
{ pkgs, inputs,  ... }:
let
  mkPkgs = name: src: pkgs.vimUtils.buildVimPlugin { inherit name src; };

  # ePlugins are the plugins that are not available in nixpkgs/nixvim coming from flakes
  ePlugins = [
    (mkPkgs "windows" inputs.windows)
    (mkPkgs "windows-mc" inputs.windows-mc)
    (mkPkgs "windows-a" inputs.windows-a)
  ];
  # nPlugins are normally available in nixpkgs
  nPlugins = with pkgs.vimPlugins; [ telescope-zoxide vim-gutentags];

in {
  # Keeping this at top so that if any plugin is removed it's respective config can be removed
  extraConfigLua = # lua
    ''
      local set= function(name)
        local ok, p = pcall(require, name)
        if ok then
          p.setup()
        end
      end
      set "windows"
    '';

  extraPlugins = nPlugins ++ ePlugins;
  extraPackages = with pkgs; [ universal-ctags curl gzip coreutils util-linux codeium ];
}
