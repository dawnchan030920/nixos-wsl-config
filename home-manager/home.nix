# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  home = {
    username = "dc392";
    homeDirectory = "/home/dc392";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    neofetch # system state graph gen
    tldr # community-driven command examples
    nix-output-monitor # additional information monitor for nix
    devenv # development environment config tool
    cachix # nix-based cache

    slides # tui slides

    # games
    nethack # dungeon game
  ];

  # home manager
  programs.home-manager.enable = true;

  # git
  programs.git = {
    enable = true;
    userName = "dawnchan030920";
    userEmail = "dawnchan030920@outlook.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # starship
  programs.starship = {
    enable = true;
    settings = {
    };
  };

  # bash
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      cls = "clear";
      upd = "sudo home-manager switch --flake /etc/nixos#dc392@nixos";
      gc = "nix-collect-garbage";
      edh = "sudo hx /etc/nixos";
      ls = "exa";
    };

    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # fish
  programs.fish = {
    enable = true;
    shellAliases = {
      cls = "clear";
      upd = "home-manager switch --flake /etc/nixos#dc392@nixos";
      gc = "nix-collect-garbage";
      edh = "sudo hx /etc/nixos";
      ls = "eza";
      zlj = "zellij";
    };
    functions = {
      y = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
	      yazi $argv --cwd-file="$tmp"
	      if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		      builtin cd -- "$cwd"
	      end
	      rm -f -- "$tmp"
      '';
      tree = ''
        set level $argv[1]
        eza --tree --level=$level --icons
      '';
    };
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
    ];
  };

  # bat
  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
  };

  # zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  # jq
  programs.jq = {
    enable = true;
  };

  # ripgrep
  programs.ripgrep = {
    enable = true;
  };

  # eza
  programs.eza = {
    enable = true;
  };

  # fzf
  programs.fzf = {
    enable = true;
  };

  # helix
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "onedark";

      editor = {
        line-number = "relative";
        bufferline = "multiple";
        true-color = true;
        color-modes = true;
        soft-wrap = {
          enable = true;
        };

        cursor-shape = {
          insert = "bar";
        };

        indent-guides = {
          render = true;
          character = "┊";
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "file-modification-indicator"
            "version-control"
          ];
          right = [
            "diagnostics"
            "selections"
            "position-percentage"
            "position"
            "file-encoding"
          ];
        };
      };

      keys.normal = {
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
      };
    };
  };

  # vscodium
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscodium;
  # };

  # lf
  # programs.lf = {
  #   enable = true;
  # };

  # zellij
  programs.zellij = {
    enable = true;
    settings = {
      theme = "one-half-dark";
    };
  };

  # btop
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "onedark";
      theme_background = false;
    };
  };

  # broot
  # programs.broot = {
  #   enable = true;
  #   enableBashIntegration = true;
  #   enableFishIntegration = true;
  # };

  # nnn
  # programs.nnn = {
  #   enable = true;
  # };

  # gitui
  programs.gitui = {
    enable = true;
  };

  # pandoc
  programs.pandoc = {
    enable = true;
  };

  # thefuck
  programs.thefuck = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  # autojump
  programs.autojump = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  # github cli
  programs.gh = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
  };

  programs.nushell = {
    enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
