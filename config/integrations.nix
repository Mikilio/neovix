{pkgs, ...}: {
  userCommands.CC.command = "CodeCompanion";
  extraConfigLuaPost =
    #lua
    ''
      function _G.run_cmd(var)
        local cmd = var:sub(5)
        local handle = io.popen(cmd, "r")
        if handle then
          local result = handle:read("*a")
          handle:close()
          local r = result:gsub("%s+$", "")
          return r
        else
          return nil
        end
      end


    '';

  plugins = {
    nix-develop = {
      enable = true;
      lazyLoad.settings.cmd = [
        "NixDevelop"
        "NixShell"
        "RiffShell"
      ];
    };

    codecompanion = {
      enable = true;
      lazyLoad.settings = {
        cmd = [
          "CodeCompanionChat"
          "CodeCompanionActions"
          "CodeCompanion"
          "CodeCompanionCmd"
        ];
        keys = [
          {
            __unkeyed-1 = "<C-a>";
            __unkeyed-2 = "<cmd>CodeCompanionActions<cr>";
            mode = [
              "n"
              "v"
            ];
            noremap = true;
            silent = true;
          }
          {
            __unkeyed-1 = "<leader>a";
            __unkeyed-2 = "<cmd>CodeCompanionChat Toggle<cr>";
            mode = [
              "n"
              "v"
            ];
            noremap = true;
            silent = true;
          }
          {
            __unkeyed-1 = "ga";
            __unkeyed-2 = "<cmd>CodeCompanionChat Add<cr>";
            mode = "v";
            noremap = true;
            silent = true;
          }
        ];
        # before = #lua
        #   ''
        #
        #   '';
      };
      settings = {
        adapters = {
          opts.show_defaults = false;

          ollama.__raw =
            # lua
            ''
              function()
                return require('codecompanion.adapters').extend('ollama', {
                    env = {
                        url = "http://127.0.0.1:11434",
                    },
                    schema = {
                        model = {
                            default = 'qwen2.5-coder:latest',
                        },
                        num_ctx = {
                            default = 4096,
                        },
                    },
                })
              end
            '';
          openrouter.__raw =
            # lua
            ''
              function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                  env = {
                    url = "https://openrouter.ai/api",
                    api_key = "cmd:pass /API/openrouter 2>/dev/null",
                    chat_url = "/v1/chat/completions",
                  },
                  schema = {
                    model = {
                      default = "google/gemini-2.0-flash-001",
                    },
                  },
                })
              end
            '';
        };
        display.chat = {
          show_settings = true;
          window.layout = "float";
        };
        opts = {
          log_level = "TRACE";
          send_code = true;
          use_default_actions = true;
          use_default_prompts = true;
        };
        strategies = {
          agent = {
            adapter = "openrouter";
          };
          chat = {
            adapter = "openrouter";
          };
          inline = {
            adapter = "openrouter";
          };
        };
      };
    };

    dap = {
      enable = true;
      lazyLoad.settings.lazy = true;
    };
    dap-python = {
      enable = true;
      lazyLoad.settings.lazy = true;
    };
    dap-lldb = {
      enable = true;
      lazyLoad.settings.lazy = true;
      settings.codelldb_path = pkgs.vscode-extensions.vadimcn.vscode-lldb;
    };
    dap-virtual-text = {
      enable = true;
      lazyLoad.settings.lazy = true;
    };
    dap-ui = {
      enable = true;
      lazyLoad.settings = {
        before =
          #lua
          ''
            function()
              local tg = require('lz.n').trigger_load
              tg('dap')
              tg('nvim-dap-virtual-text')

              local bufnr = vim.api.nvim_get_current_buf()
              local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
              local lldb = { "rust", "c", "cpp" }
              local python = { "python" }

              for _, ft in ipairs(lldb) do
                if filetype == ft then
                  tg('dap-lldb')
                  break
                end
              end

              if filetype == "python" then
                tg('dap-python')
              end
            end
          '';
        keys = [
          {
            __unkeyed-1 = "<leader>du";
            __unkeyed-2 = "<cmd>lua require('dapui').toggle()<cr>";
            mode = "n";
            desc = "Toggle DapUI";
            silent = true;
          }
        ];
      };
    };
    markdown-preview = {
      enable = true;
      # lazyLoad.settings.keys = [
      #   {
      #     __unkeyed-1 = "<leader>mp";
      #     __unkeyed-2 = ":MarkdownPreviewToggle<CR>";
      #     mode = "";
      #     desc = "Toggle Markdown Preview";
      #   }
      # ];
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

    yazi = {
      enable = true;
      lazyLoad.settings = {
        event = "DeferredUIEnter";
        keys = [
          {
            __unkeyed-1 = "<leader>e";
            __unkeyed-2 = "<cmd>Yazi<cr>";
            mode = "n";
            desc = "Open Yazi";
          }
        ];
      };
    };

    # we don't want to lazy load VimTeX https://github.com/lervag/vimtex#Installation
    vimtex = {
      enable = true;
      settings = {
        complete_enabled = false;
        parser_bib_backend = "lua";
        view_method = "sioyek";
      };
    };
  };

  extraConfigVim =
    # vimscript
    ''
      function OpenMarkdownPreview (url)
        call jobstart(['hyprctl', 'dispatch', 'exec', '[noinitialfocus\; tile]', '--', 'floorp', '-P', 'PWA', a:url] )
      endfunction
    '';
}
