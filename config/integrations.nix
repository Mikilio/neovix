{pkgs, ...}: {
  # Dependencies for integrations plugins
  dependencies = {
    opencode.packageFallback = true;
  };

  extraPackages = with pkgs; [
    # vimtex LaTeX toolchain (not declared as nixvim dependencies)
    biber # bibliography backend
    ghostscript_headless # PDF processing for sioyek viewer
  ];

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

  opts.autoread = true;

  plugins = {
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
            mode = ["n" "x"];
          }
          {
            __unkeyed-1 = "<leader>os";
            __unkeyed-2.__raw =
              #lua
              ''
                function() require("opencode").select() end
              '';
            desc = "Select OpenCode…";
            mode = ["n" "x"];
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
            mode = ["n" "x"];
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
      texlivePackage = pkgs.texliveTeTeX;
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
