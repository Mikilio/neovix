{
  description = "A satisfying NixVim config";

  inputs = {
    nixpkgs.follows = "nixvim/nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    focus = {
      url = "github:nvim-focus/focus.nvim";
      flake = false;
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixvim
    , flake-parts
    , treefmt-nix
    , ...
    } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [ treefmt-nix.flakeModule ];

      perSystem =
        { lib
        , pkgs
        , system
        , ...
        }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit system;
            module = import ./config;
            extraSpecialArgs = {
              inherit inputs;
            };
          };
          mkBinaryCheck =
            { name
            , binary
            , binaryName ? null
            ,
            }:
            let
              exe = if binaryName != null then lib.getExe' binary binaryName else lib.getExe binary;
            in
            pkgs.runCommand "${name}-check" { } ''
              ${exe} --version > $out 2>&1 || ${exe} --help > $out 2>&1 || echo "Binary present: ${binary}" > $out
            '';

          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixpkgs-fmt.enable = true;
              alejandra.enable = true;
              stylua.enable = true;
              shfmt.enable = true;
            };
            settings.formatter = {
              nixpkgs-fmt.includes = [ "*.nix" ];
              alejandra.includes = [ "*.nix" ];
              stylua.includes = [ "*.lua" ];
              shfmt.includes = [ "*.sh" ];
            };
          };

          checks = {
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;

            # Binary presence checks for heavy LSPs (fast, no headless nvim)
            lsp-rust = mkBinaryCheck {
              name = "lsp-rust";
              binary = pkgs.rust-analyzer;
            };
            lsp-python = mkBinaryCheck {
              name = "lsp-python";
              binary = pkgs.pyright;
            };
            lsp-go = mkBinaryCheck {
              name = "lsp-go";
              binary = pkgs.gopls;
            };
            lsp-clangd = mkBinaryCheck {
              name = "lsp-clangd";
              binary = pkgs.clang-tools;
              binaryName = "clangd";
            };
            lsp-ccls = mkBinaryCheck {
              name = "lsp-ccls";
              binary = pkgs.ccls;
            };
          };

          packages = {
            default = nvim;
          };

          devShells = {
            default = pkgs.mkShell {
              name = "neovix-dev";
              packages = with pkgs; [
                nvim
                nixd
                git
                ripgrep
                fd
              ];
            };
            full = pkgs.mkShell {
              name = "neovix-kitchen-sink";
              packages = with pkgs; [
                nvim
                # All heavy LSPs
                rust-analyzer
                pyright
                gopls
                jdt-language-server
                kotlin-language-server
                dart
                lua-language-server
                lemminx
                ltex-ls
                nixd
                zls
                haskell-language-server
                terraform-ls
                ccls
                clang-tools
                # VimTeX toolchain
                texliveTeTeX
                biber
                ghostscript_headless
                sioyek
                # Debuggers
                vscode-extensions.vadimcn.vscode-lldb
                python3Packages.debugpy
                # Formatters / tools (nix fmt handles these via treefmt-nix)
                alejandra
                nixpkgs-fmt
                stylua
                black
                isort
                prettierd
                google-java-format
                shfmt
              ];
            };
          };
        };
    };
}
