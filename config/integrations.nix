{ ... }:
{
  plugins = {
    nix-develop.enable = true;
    direnv.enable = true;
    dap.enable = true;
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
  keymaps = [
    {
      key = "<leader>ya";
      action.__raw = "function() require('yazi').yazi() end";
      options.desc = "Open Yazi";
    }
  ];
}
