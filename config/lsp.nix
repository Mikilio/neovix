{
  lib,
  pkgs,
  inputs,
  ...
}: {
  autoCmd = [
    {
      event = [
        "BufNewFile"
        "BufRead"
      ];
      pattern = [
        "meson.build"
        "meson_options.txt"
        "meson.options"
      ];
      callback.__raw =
        # lua
        ''
          function(args)
            local match = vim.fs.find(
              {"meson_options.txt", "meson.options", ".git"},
              {path = args.file, upward = true}
            )[1]
            local root_dir = match and vim.fn.fnamemodify(match, ":p:h") or nil
            vim.lsp.start({
              name = "mesonlsp",
              cmd = {"${lib.getExe pkgs.mesonlsp}", "--lsp"},
              root_dir = root_dir,
            })
          end
        '';
    }
  ];

  diagnostic.settings = {
    virtual_lines = {
      current_line = true;
    };
    virtual_text = false;
    severity_sort = true;
    signs = let
      hl = {
        "vim.diagnostic.severity.ERROR" = "DiagnosticError";
        "vim.diagnostic.severity.WARN" = "DiagnosticWarn";
        "vim.diagnostic.severity.INFO" = "DiagnosticInfo";
        "vim.diagnostic.severity.HINT" = "DiagnosticHint";
      };
    in {
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

      postConfig = ''
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = "rounded" })
      '';

      keymaps = {
        extra = [
          {
            mode = "n";
            key = "<leader>li";
            action = "<cmd>LspInfo<cr>";
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
        nixd.enable = true;
        bashls.enable = true;
        dartls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        kotlin_language_server.enable = true;
        jdtls = {
          enable = true;
          settings.java.project.sourcePaths = ["src" "src/main/java"];
        };
        helm_ls.enable = true;
        ccls = {
          enable = true;
          filetypes = ["c" "objc"];
        };
        clangd.enable = true;
        pyright.enable = true;
        ts_ls.enable = true;
        taplo.enable = true;
        lemminx.enable = true;
        ltex = {
          enable = true;
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
            #"mail"
          ];
        };
      };
      lazyLoad.settings.event = "BufReadPre";
    };

    blink-cmp = {
      enable = true;
      setupLspCapabilities = false;
      settings = {
        keymap.preset = "super-tab";
        sources.per_filetype.codecompanion = ["codecompanion"];
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
        event = ["InsertEnter" "CmdlineEnter"];
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

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          lua = ["stylua"];
          nix = ["alejandra"];
          python = [
            "isort"
            "black"
          ];
          javascript = ["prettierd"];
          java = ["google-java-format"];
        };
        default_format_opts.lsp_format = "fallback";
        format_on_save.timeout_ms = 500;
        formatters = {
          shfmt = {
            prepend_args = [
              "-i"
              "2"
            ];
          };
        };
      };
      lazyLoad.settings = {
        lazy = true;
        cmd = "ConformInfo";
        keys = [
          {
            __unkeyed-1 = "<leader>cF";
            __unkeyed-2.__raw = "function() require('conform').format({ async = true }) end";
            desc = "Format buffer";
          }
        ];
        before =
          # lua
          ''
            function()
              -- If you want the formatexpr, here is the place to set it
              vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
            end
          '';
      };
    };
    ltex-extra = {
      enable = true;
      settings = {
        load_langs = [
          "en-US"
          "de-DE"
        ];
        path.__raw =
          # lua
          ''
            vim.fn.expand("state") .. "/ltex"
          '';
      };
      lazyLoad.settings.ft = [
        "markdown"
        "tex"
      ];
    };
  };
}
