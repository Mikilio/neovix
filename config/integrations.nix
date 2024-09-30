{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  plugins = {
    nix-develop.enable = true;
    direnv.enable = true;
    dap.enable = true;
    codeium-nvim = {
      enable = true;
      package = pkgs.vimUtils.buildVimPlugin {
        name = "codeium-nvim";
        src = inputs.codeium;
      };
      settings = {

        enable_chat = true;
        tools = {
          curl = lib.getExe pkgs.curl;
          gzip = lib.getExe pkgs.gzip;
          uname = lib.getExe' pkgs.coreutils "uname";
          uuidgen = lib.getExe' pkgs.util-linux "uuidgen";
          language_server = lib.getExe' inputs.codeium.packages.${pkgs.system}.codeium-lsp "codeium-lsp";
        };
      };
    };
    markdown-preview = {
      enable = true;
      settings = {
        auto_close = 0;
        command_for_global = 1;
        combine_preview = 1;
        combine_preview_auto_refresh = 1;
        browserfunc = "OpenMarkdownPreview";
        echo_preview_url = 1;
        page_title = "Markdown Preview";
      };
    };
    qmk = {
      enable = true;
      settings.layout = [
        "x x"
        "x^x"
      ];
      settings.name = "TOTEM";
    };
    firenvim = {
      enable = true;
    };
    vimtex = {
      enable = true;
      settings = {
        complete_enabled = false;
        parser_bib_backend = "lua";
        view_method = "sioyek";
      };
    };
    yazi.enable = true;
  };

  extraConfigVim = # vimscript
    ''
      function OpenMarkdownPreview (url)
        call jobstart(['hyprctl', 'dispatch', 'exec', '[noinitialfocus\; tile]', '--', 'floorp', '-P', 'PWA', a:url] )
      endfunction
    '';
}
