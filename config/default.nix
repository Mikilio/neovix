{
  # Import all your configuration modules here
  imports = [
    ./mappings.nix
    ./autocmd.nix

    ./lualine.nix
    ./style.nix

    ./telescope.nix
    ./gitsigns.nix

    ./dashboard.nix
    ./lsp.nix
    ./cmp.nix

    ./utils.nix
    ./integrations.nix
    ./extern.nix
    ./opts.nix
  ];
}
