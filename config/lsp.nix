{ lib
, pkgs
, ...
}: {
  extraConfigLua =
    # lua
    ''
      _G.format_buffer = function(buf, cb)
        buf = buf or vim.api.nvim_get_current_buf()
        local path = vim.api.nvim_buf_get_name(buf)
        if path == "" then
          if cb then
            cb(false)
          end
          return
        end
        vim.system({ "nix", "fmt", path }, function(result)
          if result.code ~= 0 then
            vim.notify("nix fmt failed (exit " .. result.code .. "): " .. (result.stderr or ""), vim.log.levels.WARN)
            if cb then
              cb(false)
            end
            return
          end
          vim.api.nvim_buf_call(buf, function()
            vim.cmd("checktime")
          end)
          vim.notify("Formatted with nix fmt", vim.log.levels.INFO)
          if cb then
            cb(true)
          end
        end)
      end
    '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>cf";
      action.__raw = "function() _G.format_buffer() end";
      options.desc = "Format buffer with nix fmt";
    }
    {
      mode = "n";
      key = "<leader>uf";
      action.__raw =
        # lua
        ''
          function()
            local buf = vim.api.nvim_get_current_buf()
            local enabled = vim.b[buf].autoformat_enabled
            if enabled == nil then
              enabled = vim.g.autoformat_enabled
            end
            enabled = not (enabled ~= false)
            vim.b[buf].autoformat_enabled = enabled
            local status = enabled and "enabled" or "disabled"
            vim.notify("Buffer auto-format " .. status, vim.log.levels.INFO)
          end
        '';
      options.desc = "Toggle buffer auto-format";
    }
    {
      mode = "n";
      key = "<leader>uF";
      action.__raw =
        # lua
        ''
          function()
            local enabled = vim.g.autoformat_enabled
            if enabled == nil then
              enabled = true
            end
            enabled = not enabled
            vim.g.autoformat_enabled = enabled
            local status = enabled and "enabled" or "disabled"
            vim.notify("Global auto-format " .. status, vim.log.levels.INFO)
          end
        '';
      options.desc = "Toggle global auto-format";
    }
  ];

  diagnostic.settings = {
    virtual_lines = {
      current_line = true;
    };
    virtual_text = false;
    severity_sort = true;
    signs =
      let
        hl = {
          "vim.diagnostic.severity.ERROR" = "DiagnosticError";
          "vim.diagnostic.severity.WARN" = "DiagnosticWarn";
          "vim.diagnostic.severity.INFO" = "DiagnosticInfo";
          "vim.diagnostic.severity.HINT" = "DiagnosticHint";
        };
      in
      {
        text = {
          "vim.diagnostic.severity.ERROR" = "";
          "vim.diagnostic.severity.WARN" = "";
          "vim.diagnostic.severity.INFO" = "";
          "vim.diagnostic.severity.HINT" = "";
        };
        linehl = hl;
        numhl = hl;
      };
  };

  plugins = {
    lsp = {
      #lsp
      enable = true;
      inlayHints = true;

      keymaps = {
        extra = [
          {
            mode = "n";
            key = "<leader>li";
            action = "<cmd>checkhealth vim.lsp<cr>";
            options.desc = "Show LSP info";
          }
          {
            mode = "n";
            key = "<leader>ll";
            action.__raw = "function() vim.lsp.codelens.refresh() end";
            options.desc = "LSP CodeLens refresh";
          }
          {
            mode = "n";
            key = "<leader>lL";
            action.__raw = "function() vim.lsp.codelens.run() end";
            options.desc = "LSP CodeLens run";
          }
        ];

        lspBuf = {
          "<leader>la" = {
            action = "code_action";
            desc = "LSP code action";
          };

          "<leader>lr" = {
            action = "rename";
            desc = "LSP renaming";
          };

          gs = {
            action = "signature_help";
            desc = "View signature";
          };

          K = {
            action = "hover";
            desc = "LSP hover";
          };
        };
      };

      servers = {
        # Global lightweight servers — always available
        bashls.enable = true;
        taplo.enable = true;
        yamlls.enable = true;
        jsonls.enable = true;
        html.enable = true;
        cssls.enable = true;

        # Heavy servers — configured via lspconfig, binary from devShell
        nixd = {
          enable = true;
          package = null;
        };
        dartls = {
          enable = true;
          package = null;
        };
        rust_analyzer = {
          enable = true;
          package = null;
          installCargo = false;
          installRustc = false;
          extraOptions.root_dir = lib.nixvim.mkRaw ''
            function(bufnr)
              local fname = vim.api.nvim_buf_get_name(bufnr)
              local dir = vim.fs.dirname(fname)
              local markers = { "Cargo.toml", ".git" }
              for _, m in ipairs(markers) do
                local found = vim.fs.find(m, { upward = true, path = dir })
                if #found > 0 then
                  return vim.fs.dirname(found[1])
                end
              end
              return nil
            end
          '';
        };
        kotlin_language_server = {
          enable = true;
          package = null;
        };
        jdtls = {
          enable = true;
          package = null;
          settings.java.project.sourcePaths = [ "src" "src/main/java" ];
        };
        helm_ls = {
          enable = true;
          package = null;
        };
        ccls = {
          enable = true;
          package = null;
          extraOptions.root_dir = lib.nixvim.mkRaw ''
            function(bufnr)
              local fname = vim.api.nvim_buf_get_name(bufnr)
              local dir = vim.fs.dirname(fname)
              local found = vim.fs.find('.ccls', { upward = true, path = dir })
              if #found > 0 then
                return vim.fs.dirname(found[1])
              end
              return nil
            end
          '';
        };
        clangd = {
          enable = true;
          package = null;
          extraOptions.root_dir = lib.nixvim.mkRaw ''
            function(bufnr)
              local fname = vim.api.nvim_buf_get_name(bufnr)
              local dir = vim.fs.dirname(fname)
              local ccls = vim.fs.find('.ccls', { upward = true, path = dir })
              if #ccls > 0 then return nil end
              local markers = { '.git', 'compile_commands.json' }
              for _, m in ipairs(markers) do
                local found = vim.fs.find(m, { upward = true, path = dir })
                if #found > 0 then
                  return vim.fs.dirname(found[1])
                end
              end
              return nil
            end
          '';
        };
        pyright = {
          enable = true;
          package = null;
        };
        ts_ls = {
          enable = true;
          package = null;
        };
        lemminx = {
          enable = true;
          package = null;
        };
        ltex = {
          enable = true;
          package = null;
          filetypes = [
            "bib"
            "gitcommit"
            "markdown"
            "org"
            "plaintex"
            "rst"
            "rnoweb"
            "tex"
            "pandoc"
            "typst"
          ];
        };
        dockerls = {
          enable = true;
          package = null;
        };
        sqlls = {
          enable = true;
          package = null;
        };
        zls = {
          enable = true;
          package = null;
        };
        hls = {
          enable = true;
          package = null;
          installGhc = false;
        };
        powershell_es = {
          enable = true;
          package = null;
        };
        terraformls = {
          enable = true;
          package = null;
        };
        phpactor = {
          enable = true;
          package = null;
        };
        csharp_ls = {
          enable = true;
          package = null;
        };
        r_language_server = {
          enable = true;
          package = null;
        };
        julials = {
          enable = true;
          package = null;
        };
        lua_ls = {
          enable = true;
          package = null;
        };
        mesonlsp = {
          enable = true;
          package = null;
        };
      };
    };

    blink-cmp = {
      enable = true;
      setupLspCapabilities = false;
      settings = {
        keymap.preset = "super-tab";
        sources = {
          providers.lsp.fallbacks = [ ];
        };
      };
      luaConfig.post =
        #lua
        ''
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          vim.lsp.config('*', {
            capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
          })
        '';
      lazyLoad.settings = {
        event = [ "InsertEnter" "CmdlineEnter" ];
      };
    };
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
        incremental_selection = {
          enable = true;
          keymaps.__raw =
            # lua
            ''
              {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
              }

            '';
        };
        textobjects = {
          move.__raw =
            # lua
            ''
              {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
              }
            '';
        };
      };
      lazyLoad.settings = {
        event = "DeferredUIEnter";
        lazy.__raw =
          # lua
          ''
            vim.fn.argc(-1) == 0
          '';
      };
    };
  };
}
