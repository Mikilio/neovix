{ pkgs, ... }: {
  # Dependencies for integrations plugins
  dependencies = {
    opencode.enable = false;
    yazi.enable = false;
    sioyek.enable = false;
  };

  opts.autoread = true;

  plugins = {
    dap = {
      enable = true;
      lazyLoad.settings.lazy = true;
      adapters = {
        codelldb.__raw = ''
          function(callback, config)
            if vim.fn.executable("codelldb") ~= 1 then
              return
            end
            callback({
              type = "server",
              port = "''\${port}",
              executable = {
                command = "codelldb",
                args = {"--port", "''\${port}"},
              },
            })
          end
        '';
        python.__raw = ''
          function(callback, config)
            if vim.fn.executable("python3") ~= 1 then
              return
            end
            callback({
              type = "executable",
              command = "python3",
              args = {"-m", "debugpy.adapter"},
            })
          end
        '';
      };
      configurations =
        let
          codelldbLaunch = {
            type = "codelldb";
            request = "launch";
            name = "Launch file";
            program.__raw = "function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end";
            cwd = "\${workspaceFolder}";
            stopOnEntry = false;
          };
        in
        {
          rust = [ codelldbLaunch ];
          cpp = [ codelldbLaunch ];
          c = [ codelldbLaunch ];
          python = [
            {
              type = "python";
              request = "launch";
              name = "Launch file";
              program = "\${file}";
              pythonPath.__raw = "function() return 'python3' end";
            }
          ];
        };
    };

    nix-develop = {
      enable = true;
      lazyLoad.settings.cmd = [
        "NixDevelop"
        "NixShell"
        "RiffShell"
      ];
    };

    opencode = {
      enable = true;
      lazyLoad.settings = {
        keys = [
          {
            __unkeyed-1 = "<leader>oa";
            __unkeyed-2.__raw =
              #lua
              ''
                function() require("opencode").ask("@this: ") end
              '';
            desc = "Ask OpenCode…";
            mode = [ "n" "x" ];
          }
          {
            __unkeyed-1 = "<leader>os";
            __unkeyed-2.__raw =
              #lua
              ''
                function() require("opencode").select() end
              '';
            desc = "Select OpenCode…";
            mode = [ "n" "x" ];
          }
          {
            __unkeyed-1 = "go";
            __unkeyed-2.__raw =
              #lua
              ''
                function() return require("opencode").operator("@this ") end
              '';
            desc = "Append range to OpenCode";
            expr = true;
            mode = [ "n" "x" ];
          }
          {
            __unkeyed-1 = "goo";
            __unkeyed-2.__raw =
              #lua
              ''
                function() return require("opencode").operator("@this ") .. "_" end
              '';
            desc = "Append line to OpenCode";
            expr = true;

            mode = "n";
          }
          {
            __unkeyed-1 = "<S-C-u>";
            __unkeyed-2.__raw =
              #lua
              ''
                function() require("opencode").command("session.half.page.up") end
              '';
            desc = "Scroll OpenCode up";
            mode = "n";
          }
          {
            __unkeyed-1 = "<S-C-d>";
            __unkeyed-2.__raw =
              #lua
              ''
                function() require("opencode").command("session.half.page.down") end
              '';
            desc = "Scroll OpenCode down";
            mode = "n";
          }
        ];
      };
      settings = {
        auto_reload = false;
        server = {
          start.__raw =
            #lua
            ''
              function()
                vim.fn.jobstart({ "tmux", "new-window", "-d", "-n", "opencode", "-c", vim.fn.getcwd(-1, 0), "opencode", "--port" })
              end
            '';
        };
        prompts = {
          example = {
            description = "An example prompt configuration";
            prompt = "Write a function that returns the factorial of a number";
          };
        };
      };
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
      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<leader>e";
          __unkeyed-2.__raw =
            #lua
            ''
              function()
                if vim.fn.executable("yazi") == 1 then
                  vim.cmd("Yazi")
                else
                  vim.cmd("Explore")
                end
              end
            '';
          desc = "Open file manager (yazi or :Explore)";
          mode = "n";
        }
      ];
    };

    vimtex = {
      enable = true;
      texlivePackage = null;
      lazyLoad.settings.ft = [ "tex" "plaintex" "latex" ];
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
