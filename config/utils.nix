{ ... }:
{
  plugins = {
    persistence.enable = true;
    surround.enable = true;
    which-key.enable = true;
    ts-context-commentstring.enable = true;
    flash = {
      enable = true;
      settings = {
        labels = "arstgmneioqwfpbjluyxdcvzkh";
        rainbow.enabled = true;
        modes = {
          search.enabled = true;
          char = {
            jump_labels = true;
            char_actions = # lua
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
          treesitter_search.remote_op.motion = true;
        };
      };
    };
    comment = {

      enable = true;
      settings = {
        ignore = "^const(.*)=(%s?)%((.*)%)(%s?)=>";
        pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
      };

    };
    nvim-autopairs = {
      enable = true;
      settings = {
        fast_wrap.map = "<A-e>";
        disable_filetype = [
          "TelescopePrompt"
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
  };
  extraConfigLua = # lua
    ''
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.add_rule(Rule("$$", "$$", "tex"))

    '';
  keymaps = [
    {
      key = "s";
      mode = [
        "n"
        "x"
        "o"
      ];
      action.__raw = "function() require('flash').jump() end";
      options = {
        desc = "Flash";
        noremap = true;
      };
    }
    {
      key = "S";
      mode = [
        "n"
        "x"
        "o"
      ];
      action.__raw = "function() require('flash').treesitter() end";
      options = {
        desc = "Flash Treesitter";
        noremap = true;
      };
    }
    {
      key = "r";
      mode = [ "o" ];
      action.__raw = "function() require('flash').remote() end";
      options = {
        desc = "Remote Flash";
        noremap = true;
      };
    }
    {
      key = "R";
      mode = [
        "o"
        "x"
      ];
      action.__raw = "function() require('flash').treesitter_search() end";
      options = {
        desc = "Treesitter Search";
        noremap = true;
      };
    }
    {
      key = "<c-s>";
      mode = [ "c" ];
      action.__raw = "function() require('flash').toggle() end";
      options = {
        desc = "Toggle Flash Search";
        noremap = true;
      };
    }
  ];
}
