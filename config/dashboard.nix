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
}
