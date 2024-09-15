{ ... }:
{
  plugins = {
    octo = {
      enable = true;
      settings = {
        suppress_missing_scope = {
          projects_v2 = true;
        };
      };
    };
    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        signs = {
          add = {
            text = "▏";
          };
          change = {
            text = "▏";
          };
          delete = {
            text = "▏";
          };
          topdelete = {
            text = "󰐊";
          };
          changedelete = {
            text = "▎";
          };
        };
      };
    };
  };
}
