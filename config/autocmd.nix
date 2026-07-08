{...}: {
  autoCmd = [
    {
      desc = "Highlight on yank";
      event = ["TextYankPost"];
      callback = {
        __raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      };
    }
    # {
    #   desc = "Dim background of inactive windows";
    #   event = [ "ColorScheme" ];
    #   callback.__raw = # lua
    #     ''
    #       function()
    #         local colors = require('tinted-colorscheme').colors
    #
    #         vim.api.nvim_set_hl(0, 'Normal', {
    #           fg = colors.base05,
    #           bg = 'none',
    #           ctermfg = colors.cterm05,
    #           ctermbg = 'none',
    #         })
    #
    #         vim.api.nvim_set_hl(0, 'NormalNC', {
    #           fg = colors.base05,
    #           bg = colors.base01,
    #           ctermfg = colors.cterm05,
    #           ctermbg = colors.cterm01,
    #         })
    #       end
    #     '';
    # }

    {
      desc = "Close these type of File";
      event = ["FileType"];
      pattern = [
        "PlenaryTestPopup"
        "help"
        "lspinfo"
        "man"
        "notify"
        "qf"
        "query"
        "spectre_panel"
        "startuptime"
        "tsplayground"
        "neotest-output"
        "checkhealth"
        "neotest-summary"
        "neotest-output-panel"
      ];

      callback = {
        __raw = ''
          function(event)
            vim.bo[event.buf].buflisted = false
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
          end
        '';
      };
    }

    {
      desc = "Skip dashboard when session exists";
      event = "User";
      pattern = [
        "SnacksDashboardOpened"
      ];
      callback = {
        __raw = ''
          function()
            require('persistence').load()
              vim.schedule(function()
                pcall(vim.cmd.windo, 'edit')
              end)
          end
        '';
      };

    }

    {
      desc = "Do not save session for special";
      event = ["FileType"];
      pattern = [
        "gitcommit"
      ];
      callback.__raw =
        # lua
        ''
           function()
            require("persistence").stop()
          end
        '';
    }

    {
      desc = "Auto create dir when save file, in case some intermediate directory is missing";
      event = ["BufWritePre"];
      callback = {
        __raw = ''
          function(event)
            if event.match:match("^%w%w+://") then
              return
            end
            local file = vim.loop.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
          end
        '';
      };
    }

    {
      desc = "Disable Bufferlines for Firenvim";
      event = "UIEnter";
      callback.__raw =
        # lua
        ''
          function(event)
              local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
              if client ~= nil and client.name == "Firenvim" then
                  require('lualine').hide()
              end
          end
        '';
    }
  ];
}
