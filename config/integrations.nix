{ ... }:
{
  plugins = {
    nix-develop.enable = true;
    direnv.enable = true;
    dap.enable = true;
    markdown-preview = {
      enable = true;
      settings = {
        auto_start = false;
        auto_close = false;
        combine_preview = true;
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
    yazi.enable = true;
  };

  extraConfigVim = # vimscript
    ''
        function OpenMarkdownPreview (url)
          execute "silent ! floorp -P PWA --new-window " . a:url
        endfunction
    '';

  keymaps = [
    {
      key = "<leader>ya";
      action.__raw = "function() require('yazi').yazi() end";
      options.desc = "Open Yazi";
    }
  ];
}
