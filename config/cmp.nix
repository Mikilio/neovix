{  ... }:
{
  highlightOverride = {
    PMenu = {
      ctermbg = "none";
      bg = "none";
    };
  };

  plugins = {

    luasnip.enable = true;
    lspkind = {
      enable = true;
      symbolMap = {
        Codeium = " ";
      };
      cmp = {
        enable = true;
        maxWidth = 80;
        ellipsisChar = "...";
      };
    };

    cmp = {
      enable = true;

      settings = {
        window = {
          completion = {
            border = "rounded";
            scrollbar = false;
          };
          documentation = {
            border = "rounded";
          };
          snippet.expand.__raw = # lua
            ''
              function(args)
                require("luasnip").lsp_expand(args.body)
              end
            '';
        };
        mapping = {
          "<CR>" = "cmp.mapping.confirm({select = true })";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<Tab>" = # lua
            ''
              cmp.mapping(function(fallback)
                luasnip = require("luasnip")
                if cmp.visible() then
                  cmp.select_next_item()
                  -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                  -- they way you will only jump inside the snippet region
                elseif luasnip.expand_or_locally_jumpable() then
                  luasnip.expand_or_jump()
                elseif has_words_before() then
                  cmp.complete()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          "<S-Tab>" = # lua
            ''
              cmp.mapping(function(fallback)
                luasnip = require("luasnip")
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          "<Down>" = "cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'})";
          "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'})";
        };

        sources = [
          { name = "async_path"; }
          { name = "nvim_lsp_signature_help"; }
          {
            name = "nvim_lsp";
            keyword_length = 3;
          }
          {
            name = "nvim_lua";
            keyword_length = 2;
          }
          { name = "luasnip"; }
          {
            name = "buffer";
            keyword_length = 2;
          }
          { name = "Codeium"; }
        ];
      };
    };
  };

  extraConfigLuaPre = # lua
    ''
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
    '';
}
