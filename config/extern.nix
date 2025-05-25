{
  pkgs,
  inputs,
  ...
}: {
  extraPackages = with pkgs; [
    curl
    gzip
    coreutils
    dwt1-shell-color-scripts
    util-linux
    mermaid-cli
    imagemagick_light
    biber
    lazygit
    lldb
    texliveTeTeX
    ghostscript_headless
    cargo-nextest
    gcc
    tinty
  ];
}
