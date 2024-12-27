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
    codecompanion = {
      enable = true;
      settings = {
        display.action_palette.provider = "telescope";
        adapters = {
          ollama = {
            __raw = ''
              function()
                return require('codecompanion.adapters').extend('ollama', {
                    env = {
                        url = "http://127.0.0.1:11434",
                    },
                    schema = {
                        model = {
                            default = 'qwen2.5-coder:latest',
                            -- default = "codellama:7b",
                        },
                        num_ctx = {
                            default = 32768,
                        },
                    },
                })
              end
            '';
          };
        };
        opts = {
          log_level = "TRACE";
          send_code = true;
          use_default_actions = true;
          use_default_prompts = true;
        };
        strategies = {
          agent = {
            adapter = "ollama";
          };
          chat = {
            adapter = "ollama";
          };
          inline = {
            adapter = "ollama";
          };
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
      settings = {
        globalSettings = {
          cmdline = "none";
          content = "text";
          takeover = "once";
        };
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
}
