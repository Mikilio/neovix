{ pkgs
, inputs
, lib
, ...
}: {
  # Dependencies for snacks.nvim features
  dependencies = {
    curl.enable = true; # snacks image (download remote images)
    lazygit.enable = true; # Snacks.lazygit() keybinding
  };

  plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enabled = true;
      dashboard.sections.__raw =
        # lua
        ''
          {
            {
              section = "terminal",
              cmd = "${lib.getExe pkgs.dotacat} -F 0.2 -S 42 -p 8 ${../assets/neovim.cat}",
              hl = "header",
              padding = 5,
            },
            { section = "keys", gap = 1, padding = 1 },
          }
        '';
      indent.enabled = true;
      input.enabled = true;
      image.enabled = true;
      notifier = {
        enabled = true;
        timeout = 3000;
      };
      picker = {
        enabled = true;
      };
      terminal.enabled = false;
      quickfile.enabled = true;
      scope.enabled = true;
      scroll.enabled = true;
      statuscolumn.enabled = true;
      words.enabled = true;
    };
    lazyLoad.settings = {
      priority = 1000;
      lazy = false;
      keys = with lib.nixvim; [
        # Top Pickers & Explorer
        {
          __unkeyed-1 = "<leader><space>";
          __unkeyed-2.__raw = "function() Snacks.picker.smart() end";
          desc = "Smart Find Files";
        }
        {
          __unkeyed-1 = "<leader>,";
          __unkeyed-2.__raw = "function() Snacks.picker.buffers() end";
          desc = "Buffers";
        }
        {
          __unkeyed-1 = "<leader>/";
          __unkeyed-2.__raw = "function() Snacks.picker.grep() end";
          desc = "Grep";
        }
        {
          __unkeyed-1 = "<leader>:";
          __unkeyed-2.__raw = "function() Snacks.picker.command_history() end";
          desc = "Command History";
        }
        {
          __unkeyed-1 = "<leader>n";
          __unkeyed-2.__raw = "function() Snacks.picker.notifications() end";
          desc = "Notification History";
        }
        # find
        {
          __unkeyed-1 = "<leader>fb";
          __unkeyed-2.__raw = "function() Snacks.picker.buffers() end";
          desc = "Buffers";
        }
        {
          __unkeyed-1 = "<leader>fc";
          __unkeyed-2.__raw = "function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end";
          desc = "Find Config File";
        }
        {
          __unkeyed-1 = "<leader>ff";
          __unkeyed-2.__raw = "function() Snacks.picker.files() end";
          desc = "Find Files";
        }
        {
          __unkeyed-1 = "<leader>fg";
          __unkeyed-2.__raw = "function() Snacks.picker.git_files() end";
          desc = "Find Git Files";
        }
        {
          __unkeyed-1 = "<leader>fp";
          __unkeyed-2.__raw = "function() Snacks.picker.projects() end";
          desc = "Projects";
        }
        {
          __unkeyed-1 = "<leader>fr";
          __unkeyed-2.__raw = "function() Snacks.picker.recent() end";
          desc = "Recent";
        }
        # git
        {
          __unkeyed-1 = "<leader>gb";
          __unkeyed-2.__raw = "function() Snacks.picker.git_branches() end";
          desc = "Git Branches";
        }
        {
          __unkeyed-1 = "<leader>gl";
          __unkeyed-2.__raw = "function() Snacks.picker.git_log() end";
          desc = "Git Log";
        }
        {
          __unkeyed-1 = "<leader>gL";
          __unkeyed-2.__raw = "function() Snacks.picker.git_log_line() end";
          desc = "Git Log Line";
        }
        {
          __unkeyed-1 = "<leader>gs";
          __unkeyed-2.__raw = "function() Snacks.picker.git_status() end";
          desc = "Git Status";
        }
        {
          __unkeyed-1 = "<leader>gS";
          __unkeyed-2.__raw = "function() Snacks.picker.git_stash() end";
          desc = "Git Stash";
        }
        {
          __unkeyed-1 = "<leader>gd";
          __unkeyed-2.__raw = "function() Snacks.picker.git_diff() end";
          desc = "Git Diff (Hunks)";
        }
        {
          __unkeyed-1 = "<leader>gf";
          __unkeyed-2.__raw = "function() Snacks.picker.git_log_file() end";
          desc = "Git Log File";
        }
        # Grep
        {
          __unkeyed-1 = "<leader>sb";
          __unkeyed-2.__raw = "function() Snacks.picker.lines() end";
          desc = "Buffer Lines";
        }
        {
          __unkeyed-1 = "<leader>sB";
          __unkeyed-2.__raw = "function() Snacks.picker.grep_buffers() end";
          desc = "Grep Open Buffers";
        }
        {
          __unkeyed-1 = "<leader>sg";
          __unkeyed-2.__raw = "function() Snacks.picker.grep() end";
          desc = "Grep";
        }
        {
          __unkeyed-1 = "<leader>sw";
          __unkeyed-2.__raw = "function() Snacks.picker.grep_word() end";
          desc = "Visual selection or word";
          mode = [
            "n"
            "x"
          ];
        }
        # search
        {
          __unkeyed-1 = "<leader>s\"";
          __unkeyed-2.__raw = "function() Snacks.picker.registers() end";
          desc = "Registers";
        }
        {
          __unkeyed-1 = "<leader>s/";
          __unkeyed-2.__raw = "function() Snacks.picker.search_history() end";
          desc = "Search History";
        }
        {
          __unkeyed-1 = "<leader>sa";
          __unkeyed-2.__raw = "function() Snacks.picker.autocmds() end";
          desc = "Autocmds";
        }
        {
          __unkeyed-1 = "<leader>sb";
          __unkeyed-2.__raw = "function() Snacks.picker.lines() end";
          desc = "Buffer Lines";
        }
        {
          __unkeyed-1 = "<leader>sc";
          __unkeyed-2.__raw = "function() Snacks.picker.command_history() end";
          desc = "Command History";
        }
        {
          __unkeyed-1 = "<leader>sC";
          __unkeyed-2.__raw = "function() Snacks.picker.commands() end";
          desc = "Commands";
        }
        {
          __unkeyed-1 = "<leader>sd";
          __unkeyed-2.__raw = "function() Snacks.picker.diagnostics() end";
          desc = "Diagnostics";
        }
        {
          __unkeyed-1 = "<leader>sD";
          __unkeyed-2.__raw = "function() Snacks.picker.diagnostics_buffer() end";
          desc = "Buffer Diagnostics";
        }
        {
          __unkeyed-1 = "<leader>sh";
          __unkeyed-2.__raw = "function() Snacks.picker.help() end";
          desc = "Help Pages";
        }
        {
          __unkeyed-1 = "<leader>sH";
          __unkeyed-2.__raw = "function() Snacks.picker.highlights() end";
          desc = "Highlights";
        }
        {
          __unkeyed-1 = "<leader>si";
          __unkeyed-2.__raw = "function() Snacks.picker.icons() end";
          desc = "Icons";
        }
        {
          __unkeyed-1 = "<leader>sj";
          __unkeyed-2.__raw = "function() Snacks.picker.jumps() end";
          desc = "Jumps";
        }
        {
          __unkeyed-1 = "<leader>sk";
          __unkeyed-2.__raw = "function() Snacks.picker.keymaps() end";
          desc = "Keymaps";
        }
        {
          __unkeyed-1 = "<leader>sl";
          __unkeyed-2.__raw = "function() Snacks.picker.loclist() end";
          desc = "Location List";
        }
        {
          __unkeyed-1 = "<leader>sm";
          __unkeyed-2.__raw = "function() Snacks.picker.marks() end";
          desc = "Marks";
        }
        {
          __unkeyed-1 = "<leader>sM";
          __unkeyed-2.__raw = "function() Snacks.picker.man() end";
          desc = "Man Pages";
        }
        {
          __unkeyed-1 = "<leader>sp";
          __unkeyed-2.__raw = "function() Snacks.picker.lazy() end";
          desc = "Search for Plugin Spec";
        }
        {
          __unkeyed-1 = "<leader>sq";
          __unkeyed-2.__raw = "function() Snacks.picker.qflist() end";
          desc = "Quickfix List";
        }
        {
          __unkeyed-1 = "<leader>sR";
          __unkeyed-2.__raw = "function() Snacks.picker.resume() end";
          desc = "Resume";
        }
        {
          __unkeyed-1 = "<leader>su";
          __unkeyed-2.__raw = "function() Snacks.picker.undo() end";
          desc = "Undo History";
        }
        {
          __unkeyed-1 = "<leader>uC";
          __unkeyed-2.__raw = "function() Snacks.picker.colorschemes() end";
          desc = "Colorschemes";
        }
        # LSP
        {
          __unkeyed-1 = "gd";
          __unkeyed-2.__raw = "function() Snacks.picker.lsp_definitions() end";
          desc = "Goto Definition";
        }
        {
          __unkeyed-1 = "gD";
          __unkeyed-2.__raw = "function() Snacks.picker.lsp_declarations() end";
          desc = "Goto Declaration";
        }
        {
          __unkeyed-1 = "gr";
          __unkeyed-2.__raw = "function() Snacks.picker.lsp_references() end";
          nowait = true;
          desc = "References";
        }
        {
          __unkeyed-1 = "gI";
          __unkeyed-2.__raw = "function() Snacks.picker.lsp_implementations() end";
          desc = "Goto Implementation";
        }
        {
          __unkeyed-1 = "gy";
          __unkeyed-2.__raw = "function() Snacks.picker.lsp_type_definitions() end";
          desc = "Goto T[y]pe Definition";
        }
        {
          __unkeyed-1 = "<leader>ss";
          __unkeyed-2.__raw = "function() Snacks.picker.lsp_symbols() end";
          desc = "LSP Symbols";
        }
        {
          __unkeyed-1 = "<leader>sS";
          __unkeyed-2.__raw = "function() Snacks.picker.lsp_workspace_symbols() end";
          desc = "LSP Workspace Symbols";
        }
        # Other
        {
          __unkeyed-1 = "<leader>z";
          __unkeyed-2.__raw = "  function() Snacks.zen() end";
          desc = "Toggle Zen Mode";
        }
        {
          __unkeyed-1 = "<leader>Z";
          __unkeyed-2.__raw = "  function() Snacks.zen.zoom() end";
          desc = "Toggle Zoom";
        }
        {
          __unkeyed-1 = "<leader>.";
          __unkeyed-2.__raw = "  function() Snacks.scratch() end";
          desc = "Toggle Scratch Buffer";
        }
        {
          __unkeyed-1 = "<leader>S";
          __unkeyed-2.__raw = "  function() Snacks.scratch.select() end";
          desc = "Select Scratch Buffer";
        }
        {
          __unkeyed-1 = "<leader>n";
          __unkeyed-2.__raw = "  function() Snacks.notifier.show_history() end";
          desc = "Notification History";
        }
        {
          __unkeyed-1 = "<leader>bd";
          __unkeyed-2.__raw = "function() Snacks.bufdelete() end";
          desc = "Delete Buffer";
        }
        {
          __unkeyed-1 = "<leader>cR";
          __unkeyed-2.__raw = "function() Snacks.rename.rename_file() end";
          desc = "Rename File";
        }
        {
          __unkeyed-1 = "<leader>gB";
          __unkeyed-2.__raw = "function() Snacks.gitbrowse() end";
          desc = "Git Browse";
          mode = [
            "n"
            "v"
          ];
        }
        {
          __unkeyed-1 = "<leader>gg";
          __unkeyed-2.__raw = "function() Snacks.lazygit() end";
          desc = "Lazygit";
        }
        {
          __unkeyed-1 = "<leader>un";
          __unkeyed-2.__raw = "function() Snacks.notifier.hide() end";
          desc = "Dismiss All Notifications";
        }
        {
          __unkeyed-1 = "]]";
          __unkeyed-2.__raw = "function() Snacks.words.jump(vim.v.count1) end";
          desc = "Next Reference";
          mode = [
            "n"
            "t"
          ];
        }
        {
          __unkeyed-1 = "[[";
          __unkeyed-2.__raw = "function() Snacks.words.jump(-vim.v.count1) end";
          desc = "Prev Reference";
          mode = [
            "n"
            "t"
          ];
        }

        {
          __unkeyed-1 = "<leader>N";
          __unkeyed-2.__raw =
            # lua
            ''
              function()
                Snacks.win({
                  file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                  width = 0.6,
                  height = 0.6,
                  wo = {
                    spell = false,
                    wrap = false,
                    signcolumn = "yes",
                    statuscolumn = " ",
                    conceallevel = 3,
                  },
                })
              end
            '';
          desc = "Neovim News";
        }
      ];
      beforeAll =
        # lua
        ''
          function()
          vim.api.nvim_create_autocmd("User", {
              pattern = "DeferredUIEnter",
              callback = function()
                _G.dd = function(...) Snacks.debug.inspect(...) end
                _G.bt = function() Snacks.debug.backtrace() end
                vim.print = _G.dd

                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
              end,
            })
          end
        '';
    };
  };
}
