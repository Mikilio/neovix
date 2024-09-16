 _ :
{
  plugins = {
    navic = {
      enable = true;
      settings = {
        highlight = true;
        lsp = {
          auto_attach = true;
          preference = [
            "nixd"
            "clangd"
            "tsserver"
          ];
        };
      };
    };

    lualine = {
      enable = true;
      settings = {
        options = {
          globalstatus = true;
          componentSeparators = {
            left = "|";
            right = "|";
          };
          sectionSeparators = {
            left = "";
            right = "";
          };
        };

        tabline = {
          lualine_a = [
            {
              __unkeyed-1.__raw = # lua
                ''
                  function()
                    return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
                  end
                '';
              separator = {
                left = "";
                right = "";
              };
              icon = " ";
            }
          ];
          lualine_b = [ ];
          lualine_c = [ ];
          lualine_x = [ ];
          lualine_y = [
            {
              __unkeyed-1 = "windows";
              separator = {
                left = "";
                right = "";
              };
            }
            {
              __unkeyed-1 = "%=";
              separator = {
                right = "";
              };
              color = "lualine_c_normal";
            }
          ];
          lualine_z = [
            {
              __unkeyed-1 = "tabs";
              separator = {
                left = "";
                right = "";
              };
            }
          ];
        };

        winbar = {
          lualine_c = [
            {
              __unkeyed-1.__raw = # lua
                ''
                  function()
                    return require("nvim-navic").get_location()
                  end
                '';
              cond.__raw = # lua
                ''
                  function()
                    return require("nvim-navic").is_available()
                  end
                '';
            }
          ];
        };

        sections = {
          lualine_a = [
            {
              __unkeyed-1 = "mode";
              separator.left = "";
              padding = 2;
            }
          ];
          lualine_b = [
            { __unkeyed-1 = "branch"; }
            {
              __unkeyed-1 = "diff";
              symbols = {
                added = " ";
                modified = " ";
                removed = " ";
              };
            }
            {
              __unkeyed-1 = "diagnostics";
              sources = [ "nvim_diagnostic" ];
              symbols = {
                error = " ";
                warn = " ";
                info = " ";
              };
            }
          ];
          lualine_c = [
            {
              __unkeyed-1 = "file_name";
              color.gui = "bold";
              separator.right = "";
            }
            "%="
            {
              __unkeyed-1.__raw = # lua
                ''
                  function()
                    local msg = "Inactive"
                    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                      return msg
                    end
                    local t = {}
                    for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        t[#t + 1] = client.name
                      end
                    end
                    if (#t > 0)
                    then
                      return table.concat(t, ", ")
                    end
                    return msg
                  end
                '';
              icon = " LSP:";
              color.gui = "bold";
            }
          ];
          lualine_x = [ ];
          lualine_y = [
            {
              __unkeyed-1 = "filetype";
              separator.left = "";
            }
            "progress"
          ];
          lualine_z = [
            {
              __unkeyed-1 = "location";
              separator.right = "";
              padding = 2;
            }
          ];
        };
      };
    };
  };
}
