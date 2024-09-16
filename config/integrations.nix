{ ... }:
{
  plugins = {
    nix-develop.enable = true;
    direnv.enable = true;
    dap.enable = true;
    markdown-preview = {
      enable = true;
      settings = {
        auto_close = false;
        command_for_global = true;
        combine_preview = true;
        combine_preview_auto_refresh = true;
        browserfunc = "OpenMarkdownPreview";
        echo_preview_url = true;
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
      settings = {
        globalSettings = {
          cmdline = "neovim";
          content = "text";
          priority = 0;
          selector = "textarea";
          takeover = "never";
        };
        localSettings = { ".*" = { takeover = "never"; }; };
      };
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

  keymaps = [
    {
      key = "<leader>ya";
      action.__raw = "function() require('yazi').yazi() end";
      options.desc = "Open Yazi";
    }
    {
      key = "<leader>mp";
      action = ":MarkdownPreviewToggle<CR>";
      options.desc = "Toggle Markdown Preview";
    }
  ];
}
