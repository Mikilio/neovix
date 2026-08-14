{ pkgs
, inputs
, ...
}: {
  # Dependencies for integrations plugins
  dependencies = {
    yazi.enable = false;
    sioyek.enable = false;
  };

  # herdr-nvim: code annotations (comment lines/selection, send to herdr agent).
  # The herdr plugin half (sidebar + file picker) installs separately via
  # `herdr plugin install ChmaraX/herdr-nvim`.
  extraPackages = [ pkgs.herdr ];

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "herdr-nvim";
      version = "0.1.1";
      src = inputs.herdr-nvim;
    })
  ];

  plugins.lz-n.plugins = [
    {
      __unkeyed-1 = "herdr-nvim";
      event = "DeferredUIEnter";
      after.__raw =
        # lua
        ''
          require("herdr-nvim").setup({})
        '';
    }
  ];

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
              tg('nvim-dap')
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
