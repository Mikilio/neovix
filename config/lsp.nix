{
  lib,
  pkgs,
  ...
}:
{
  # Utility Plugins

  extraConfigLuaPost = ''
    vim.api.nvim_create_user_command("LtexLangChangeLanguage", function(data)
        local language = data.fargs[1]
        local bufnr = vim.api.nvim_get_current_buf()
        local client = vim.lsp.get_active_clients({ bufnr = bufnr, name = 'ltex' })
        if #client == 0 then
            vim.notify("No ltex client attached")
        else
            client = client[1]
            client.config.settings = {
                ltex = {
                    language = language
                }
            }
            client.notify('workspace/didChangeConfiguration', client.config.settings)
            vim.notify("Language changed to " .. language)
        end
      end, {
        nargs = 1,
        force = true,
    })
  '';

  # Language Servers

  extraConfigLuaPre = ''
    local efm_fs = require('efmls-configs.fs')
    local djlint_fmt = {
      formatCommand = string.format('%s --reformat ''${INPUT} -', efm_fs.executable('djlint')),
      formatStdin = true,
    }
  '';

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
      callback.__raw = # lua
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

  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      settings = {
        highlight.enable = true;
        incremental_selection.enable = true;
        indent.enable = true;
      };
    };
    efmls-configs = {
      enable = true;

      toolPackages.mdformat = pkgs.mdformat.withPlugins (
        ps: with ps; [
          # TODO: broken with update of mdformat
          # mdformat-gfm
          mdformat-frontmatter
          mdformat-footnote
          mdformat-tables
          mdit-py-plugins
        ]
      );

      setup = {
        sh = {
          #linter = "shellcheck";
          formatter = "shfmt";
        };
        bash = {
          #linter = "shellcheck";
          formatter = "shfmt";
        };
        c = {
          linter = "cppcheck";
        };
        markdown = {
          formatter = [
            "cbfmt"
            "mdformat"
          ];
        };
        python = {
          formatter = "black";
        };
        nix = {
          linter = "statix";
        };
        lua = {
          formatter = "stylua";
        };
        html = {
          formatter = [
            "prettier"
            { __raw = "djlint_fmt"; }
          ];
        };
        htmldjango = {
          formatter.__raw = "djlint_fmt";
          linter = "djlint";
        };
        json = {
          formatter = "prettier";
        };
        css = {
          formatter = "prettier";
        };
        ts = {
          formatter = "prettier";
        };
        gitcommit = {
          linter = "gitlint";
        };
      };
    };

    lsp = {
      enable = true;

      postConfig = ''
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

        vim.diagnostic.config({
          virtual_text = true,
          signs = true,
          underline = true,
          update_in_insert = true,
          severity_sort = false,
        })

        local signs = {
          Error = "",
          Warn = "",
          Info = "",
          Hint = "",
        }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
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
          {
            key = "gr";
            action = "<cmd>Telescope lsp_references<CR>";
            options.desc = "Show references";
          }
          {
            key = "gI";
            action = "<cmd>Telescope lsp_implementations<CR>";
            options.desc = "Show implementations";
          }
          {
            key = "gW";
            action = "<cmd>Telescope lsp_workspace_symbols<CR>";
            options.desc = "Show symbols in Workspace";
          }
          {
            key = "gF";
            action = "<cmd>Telescope lsp_document_symbols<CR>";
            options.desc = "Show symbols in Document";
          }
          {
            key = "ge";
            action = "<cmd>Telescope diagnostics bufnr=0<CR>";
            options.desc = "Show all Errors in Document";
          }
          {
            key = "gE";
            action = "<cmd>Telescope diagnostics<CR>";
            options.desc = "Show all Errors";
          }
        ];

        lspBuf = {
          "<leader>la" = {
            action = "code_action";
            desc = "LSP code action";
          };

          "<leader>lf" = {
            action = "format";
            desc = "LSP code formatting";
          };

          "<leader>lr" = {
            action = "rename";
            desc = "LSP renaming";
          };

          gs = {
            action = "signature_help";
            desc = "View signature";
          };

          gd = {
            action = "definition";
            desc = "Go to definition";
          };

          gD = {
            action = "declaration";
            desc = "Go to declaration";
          };

          gt = {
            action = "type_definition";
            desc = "Go to type definition";
          };

          K = {
            action = "hover";
            desc = "LSP hover";
          };
        };
      };

      servers = {
        nixd = {
          enable = true;
          settings = {
            formatting.command = [ (lib.getExe pkgs.nixfmt-rfc-style) ];
            # options =
            #   let
            #     getFlake = ''(builtins.getFlake "${flake}")'';
            #   in
            #   {
            #     nixos.expr = ''${getFlake}.nixosConfigurations.ZeNixComputa.options'';
            #     nixvim.expr = ''${getFlake}.packages.${pkgs.system}.neovimTraxys.options'';
            #     home-manager.expr = ''${getFlake}.homeConfigurations."boyerq@thinkpad-nixos".options'';
            #   };
          };
        };
        bashls.enable = true;
        dartls.enable = true;
        clangd.enable = true;
        ts-ls.enable = true;
        efm.extraOptions = {
          init_options = {
            documentFormatting = true;
          };
          settings = {
            logLevel = 1;
          };
        };
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
    };

    ltex-extra = {
      enable = true;
      settings = {
        load_langs = [
          "en-US"
          "de-DE"
        ];
        path = ".ltex";
      };

    };

    rustaceanvim = {
      enable = true;

      settings.server = {
        default_settings.rust-analyzer = {
          cargo.features = "all";
          checkOnSave = true;
          check.command = "clippy";
          rustc.source = "discover";
        };
      };
    };

    clangd-extensions = {
      enable = true;
      enableOffsetEncodingWorkaround = true;

      ast = {
        roleIcons = {
          type = "";
          declaration = "";
          expression = "";
          specifier = "";
          statement = "";
          templateArgument = "";
        };
        kindIcons = {
          compound = "";
          recovery = "";
          translationUnit = "";
          packExpansion = "";
          templateTypeParm = "";
          templateTemplateParm = "";
          templateParamObject = "";
        };
      };
    };

  };

}
