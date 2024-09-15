{ ... }: {
  plugins.dashboard = {
    # TODO: search for fix when free
    enable = true;
    settings = {
      hide = { tabline = false; };
      disable_move = true;
      theme = "hyper";
      config = {
        packages = { enable = false; };
        week_header.enable = true;
        footer = [ " " " " "Don't Stop Until You are Proud..." ];
        project = { enable = false; };
        shortcut = [
          {
            desc = " Last Session";
            group = "Number";
            key = "<CR>";
            action = { __raw = "function() require('persistence').load() end";};
          }
          {
            desc = "";
            group = "DiagnosticHint";
            key = "f";
            action = "Telescope find_files";
          }
          {
            desc = "󱎸  Find text";
            group = "String";
            key = "t";
            action = "Telescope live_grep";
          }
          {
            desc = "";
            group = "DiagnosticError";
            key = "q";
            action = "qa";
          }

        ];
      };
    };
  };
}
