{ pkgs
, inputs
, ...
}: {
  plugins = {
    persistence = {
      enable = true;
      autoLoad = true;
      settings = {
        dir.__raw =
          # lua
          ''
            vim.fn.stdpath("state") .. "/sessions/"
          '';
        need = 1;
        branch = true;
      };
    };
    nvim-surround = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
    which-key = {
      enable = true;
      lazyLoad.settings = {
        event = "DeferredUIEnter";
        keys = [
          {
            __unkeyed-1 = "<leader>?";
            __unkeyed-2.__raw = "function() require('which-key').show({ global = false }) end";
            desc = "Buffer Local Keymaps (which-key)";
          }
        ];
      };
      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>a";
            group = "Annotations";
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "Code / Format";
          }
          {
            __unkeyed-1 = "<leader>l";
            group = "LSP";
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "UI / Toggles";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "Snacks Picker";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "Find Files/Buffers";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "DAP";
          }
          {
            __unkeyed-1 = "<leader>b";
            group = "Buffer Action";
          }
        ];
      };
    };
    todo-comments.enable = true;
    flash = {
      enable = true;
      settings = {
        labels = "arstgmneioqwfpbjluyxdcvzkh";
        modes = {
          char = {
            jump_labels = true;
            char_actions.__raw =
              # lua
              ''
                function(motion)
                  return {
                    [";"] = "next", -- set to `right` to always go right
                    [","] = "prev", -- set to `left` to always go left
                    -- jump2d style: same case goes next, opposite case goes prev
                    [motion] = "next",
                    [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
                  }
                end
              '';
          };
        };
      };
      lazyLoad.settings = {
        event = "DeferredUIEnter";
        keys = [
          {
            __unkeyed-1 = "s";
            mode = [
              "n"
              "x"
              "o"
            ];
            __unkeyed-2.__raw = "function() require('flash').jump() end";
            desc = "Flash";
          }
          {
            __unkeyed-1 = "S";
            mode = [
              "n"
              "x"
              "o"
            ];
            __unkeyed-2.__raw = "function() require('flash').treesitter() end";
            desc = "Flash Treesitter";
          }
          {
            __unkeyed-1 = "r";
            mode = "o";
            __unkeyed-2.__raw = "function() require('flash').remote() end";
            desc = "Remote Flash";
          }
          {
            __unkeyed-1 = "R";
            mode = [
              "o"
              "x"
            ];
            action.__raw = "function() require('flash').treesitter_search() end";
            desc = "Treesitter Search";
          }
        ];
      };
    };
    ts-context-commentstring = {
      enable = true;
      disableAutoInitialization = true;
    };
    comment = {
      enable = true;
      settings.pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
      # lazyLoad.settings.event = "DeferredUIEnter";
    };
    nvim-autopairs = {
      enable = true;
      lazyLoad.settings = {
        event = "InsertEnter";
      };
      settings = {
        fast_wrap.map = "<A-e>";
        disable_filetype = [
          "snacks_input"
          "snacks_picker_input"
          "vim"
        ];
        check_ts = true;
        ts_config = {
          lua = [
            "string"
            "source"
          ];
          javascript = [
            "string"
            "template_string"
          ];
        };
        map_bs = false;
      };
    };
    smart-splits = {
      enable = true;
      lazyLoad.settings.keys = [
        {
          __unkeyed-2.__raw = "function() require('smart-splits').resize_left() end";
          __unkeyed-1 = "<A-Left>";
          mode = "n";
          desc = "Resize Left";
          noremap = true;
        }
        {
          __unkeyed-2.__raw = "function() require('smart-splits').resize_down() end";
          __unkeyed-1 = "<A-Down>";
          mode = "n";
          desc = "Resize Down";
          noremap = true;
        }
        {
          __unkeyed-2.__raw = "function() require('smart-splits').resize_up() end";
          __unkeyed-1 = "<A-Up>";
          mode = "n";
          desc = "Resize Up";
          noremap = true;
        }
        {
          __unkeyed-2.__raw = "function() require('smart-splits').resize_right() end";
          __unkeyed-1 = "<A-Right>";
          mode = "n";
          desc = "Resize Right";
          noremap = true;
        }
        {
          __unkeyed-2.__raw = "function() require('smart-splits').move_cursor_left() end";
          __unkeyed-1 = "<C-Left>";
          mode = "n";
          desc = "Move Left";
          noremap = true;
        }
        {
          __unkeyed-2.__raw = "function() require('smart-splits').move_cursor_down() end";
          __unkeyed-1 = "<C-Down>";
          mode = "n";
          desc = "Move Down";
          noremap = true;
        }
        {
          __unkeyed-2.__raw = "function() require('smart-splits').move_cursor_up() end";
          __unkeyed-1 = "<C-Up>";
          mode = "n";
          desc = "Move Up";
          noremap = true;
        }
        {
          __unkeyed-2.__raw = "function() require('smart-splits').move_cursor_right() end";
          __unkeyed-1 = "<C-Right>";
          mode = "n";
          desc = "Move Right";
          noremap = true;
        }
      ];
    };
    lz-n.plugins = [
      {
        __unkeyed-1 = "focus";
        event = "BufWinEnter";
        after.__raw =
          #lua
          ''
            require("focus").setup({
              autoresize = { focusedwindow_minwidth = 80},
              ui = {
                absolutenumber_unfocussed = true,
                hybridnumber = true,
                signcolumn = false,
                winhighlight = true,
              },
            })
          '';
      }
    ];
  };
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "focus";
      src = inputs.focus;
    })
  ];
}
