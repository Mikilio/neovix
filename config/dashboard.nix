{ pkgs, lib, ... }:
{
  plugins.alpha =
    let

      buttons = button: action: desc: {
        on_press = action;
        opts = {
          position = "center";
          shortcut = button;
          keymap = [
            "n"
            button
            action
            {
              noremap = true;
              silent = true;
              nowait = true;
            }
          ];
          cursor = 3;
          width = 50;
          align_shortcut = "right";
          hl_shortcut = "Keyword";
        };
        type = "button";
        val = desc;
      };

    in
    {
      enable = true;
      layout = [
        {
          type = "padding";
          val = 2;
        }
        {
          type = "terminal";
          command = "${lib.getExe pkgs.lolcat} -t -F 0.2 -S 42 -p 8 ${../assets/neovim.cat}";
          width = 58;
          height = 8;
          opts = {
            redraw = true;
          };

        }
        {
          type = "padding";
          val = 2;
        }
        {
          type = "group";
          val = [
            (buttons "s" {
              __raw = "function() require('persistence').load() end";
            } " Last Session")
            (buttons "e" {
              __raw = "function() vim.cmd[[ene]] end";
            } "  New file")
            (buttons "q" {
              __raw = "function() vim.cmd[[qa]] end";
            } " Quit Neovim")
          ];
          opts.spacing = 1;
        }
        {
          type = "padding";
          val = 2;
        }
        {
          opts = {
            hl = "Keyword";
            position = "center";
          };
          type = "text";
          val = "Inspiring quote here.";
        }
      ];
    };
  extraConfigLuaPre = # lua
    ''
      local function getLen(str, start_pos)
        local byte = string.byte(str, start_pos)
        if not byte then
          return nil
        end
        
        return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
      end

      local function colorize(header, header_color_map, colors)
        for letter, color in pairs(colors) do
          local color_name = "Alpha-" .. letter
          vim.api.nvim_set_hl(0, color_name, color)
          colors[letter] = color_name
        end

        local colorized = {}

        for i, line in ipairs(header_color_map) do
          local colorized_line = {}
          local pos = 0

          for j = 1, #line do
            local start = pos
            pos = pos + getLen(header[i], start + 1)

            local color_name = colors[line:sub(j, j)]
            if color_name then
              table.insert(colorized_line, { color_name, start, pos })
            end
          end

          table.insert(colorized, colorized_line)
        end

        return colorized
      end

      local base16 = require('base16-colorscheme').colors;

      local header = {
        [[                                                        ]],
        [[      ████ ██████           █████      ██         ]],
        [[     ███████████             █████         █   ]],
        [[     █████████ ███████████████████ ███  ███]],
        [[    █████████  ███    █████████████ █████  ███ ]],
        [[   █████████ ██████████ █████████ █████  ███ ]],
        [[ ███████████ ███    ███ █████████ █████ ████]],
        [[██████  █████████████████████ ████ █████ ██ ██]],
      }

      local color_map = {
        [[                                             77           ]],
        [[      DDDDDD DDDDDDDD           EEEEEEE      7777         ]],
        [[     DDDDDDDDDDDDDDD             EEEEEEE E        EEE  EE ]],
        [[     DDDDDDDDDDDDD CCCCCCCCCCDDDDDEEEEEEEEEE 7777  EEEEEEE]],
        [[    DDDDDDDDDDDDD  CCCCC    DDDDDDDEEEEEEEEE 77777  EEEEE ]],
        [[   DDDDDDDDDDDDD CCCCCCCCCCDDDD DDDDEEEEEEEE 77777  EEEEE ]],
        [[ DDDDDDDDDDDDDDD CCCCC    DDDDD DDDDDEEEEEEE 77777 EEEEEEE]],
        [[DDDDDDDD  DDDDDCCCCCCCCCCDDDDDDDDDDDD EEEEEE 77777 EEE EEE]],
      }

      local colors = {
        ["0"] = { fg = base16.base00 },
        ["1"] = { fg = base16.base01 },
        ["2"] = { fg = base16.base02 },
        ["3"] = { fg = base16.base03 },
        ["4"] = { fg = base16.base04 },
        ["5"] = { fg = base16.base05 },
        ["6"] = { fg = base16.base06 },
        ["7"] = { fg = base16.base07 },
        ["8"] = { fg = base16.base08 },
        ["9"] = { fg = base16.base09 },
        ["A"] = { fg = base16.base0A },
        ["B"] = { fg = base16.base0B },
        ["C"] = { fg = base16.base0C },
        ["D"] = { fg = base16.base0D },
        ["E"] = { fg = base16.base0E },
        ["F"] = { fg = base16.base0F },
      }
    '';
}
