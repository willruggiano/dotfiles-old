{ pkgs, lib, ... }:

let
  username = "bombadil";
  homedir = "/home/${username}";

  unstable = import <unstable> { };

  colorscheme = "tokyonight";
  font = "JetBrainsMono";

  dirs = {
    configs = ../../dotfiles;
  };
in
{
  home = {
    username = username;
    homeDirectory = homedir;
    stateVersion = "21.05";

    packages = with pkgs; [
      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

      # Languages
      (python39.withPackages (
        ps: with ps; [ pip ]
      ))

      # Utilities
      awscli2
      cryptsetup
      curl
      delta
      fd
      git
      gitflow
      jq
      paperkey
      pinentry-curses
      pre-commit
      ranger
      ripgrep
      tree
      unzip
      wget
      yq
      yubikey-manager

      # X11
      xclip
    ];

    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim -c 'set ft=man' -";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
      }))
    ];
  };

  fonts.fontconfig.enable = true;

  programs.home-manager = {
    enable = true;
    path = "...";
  };

  xdg.configFile = {
    i3 = {
      source = (dirs.configs + /i3);
    };

    nvim = {
      source = (dirs.configs + /nvim);
      recursive = true;
    };

    "nvim/lua/${username}/lsp/sumneko.lua" = {
      text = (import (dirs.configs + "/nvim/lua/${username}/lsp/sumneko.lua.nix"));
    };
  };

  programs.bat = {
    enable = true;
    config = {
      map-syntax = "*.tpp:C++";
    };
  };

  programs.browserpass = {
    enable = true;
    browsers = [ "firefox" ];
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        settings = {
          "general.smoothScroll" = false;
        };
      };
    };
  };

  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    changeDirWidgetCommand = "fd --type d";
    fileWidgetCommand = "fd --type f";
  };

  programs.gh = {
    enable = true;
    editor = "nvim";
    gitProtocol = "https";
  };

  programs.git = {
    enable = true;
    userName = "Will Ruggiano";
    userEmail = "wmruggiano@gmail.com";
    extraConfig = {
      color = {
        ui = "auto";
      };
      core = {
        pager = "delta";
      };
      credential = {
        "https://github.com" = {
          helper = "!gh auth git-credential";
        };
      };
      delta = {
        features = "side-by-side line-numbers decorations";
        whitespace-error-style = "22 reverse";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
    };
    aliases = {
      dag = "log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)\"%an\" <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s' --date-order";
      ll = "log -n1";
      lo = "log --oneline";
      llo = "log -n1 --oneline";
      loq = "log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative";
      amend = "commit -a --amend --no-edit";
    };
  };

  programs.go = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
  };

  programs.htop = {
    enable = true;
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        blocks = [
          {
            block = "disk_space";
            path = "/";
            alias = "/";
            info_type = "available";
            unit = "GB";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            display_type = "memory";
            format_mem = "{mem_used_percents}";
            format_swap = "{swap_used_percents}";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            interval = 1;
            format = "{1m}";
          }
          { block = "sound"; }
          {
            block = "time";
            interval = 60;
            format = "%a %d/%m %R";
          }
        ];
        settings = {
          theme = {
            name = "solarized-dark";
            overrides = {
              idle_bg = "#123456";
              idle_fg = "#abcdef";
            };
          };
        };
        icons = "awesome5";
        theme = "gruvbox-dark";
      };
    };
  };

  programs.kitty = {
    enable = true;

    settings = {
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "JetBrainsMono Nerd Font Bold";
      bold_italic_font = "JetBrainsMono Nerd Font Bold Italic";
      italic_font = "JetBrainsMono Nerd Font Italic";
      sync_to_monitor = "no";
      disable_ligatures = "never";

      enable_audio_bell = "no";

      include = "~/dotfiles/kitty/kitty_tokyonight_storm.conf";
      dynamic_background_opacity = true;

      symbol_map = "U+f101-U+f208 nonicons";
    };
  };

  programs.mpv = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;
    extraPython3Packages = (ps: with ps; [
      isort
      pynvim
    ]);
    extraPackages = with pkgs; [
      binutils-unwrapped
      cmake
      clang-tools
      cmake-format
      cmake-language-server
      delta
      fd
      gcc11
      gcc11Stdenv
      gnumake
      luajitPackages.luafilesystem
      ninja
      nixpkgs-fmt
      nodePackages.prettier
      openssl
      python-language-server
      ripgrep
      rustfmt
      unstable.stylua
      sumneko-lua-language-server
      tree-sitter
      yapf
    ];
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-update ]);
  };

  programs.rofi = {
    enable = true;
    pass.enable = true;
  };

  programs.ssh = {
    enable = true;
    serverAliveInterval = 60;
  };

  programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [
        "$hostname"
        "$directory"
        "$git_branch"
        "$line_break"
        "$character"
      ];
      scan_timeout = 30;
      command_timeout = 500;
      add_newline = true;

      character = {
        disabled = false;
        format = "$symbol ";
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[❮](bold green)";
      };

      directory = {
        disabled = false;
        truncation_length = 3;
        truncate_to_repo = true;
        fish_style_pwd_dir_length = 0;
        use_logical_path = true;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "cyan bold";
        read_only = "🔒";
        read_only_style = "red";
        truncation_symbol = "";
        home_symbol = "~";
      };

      git_branch = {
        disabled = false;
        format = "on [$symbol$branch]($style)(:[$remote]($style)) ";
        style = "bold purple";
        symbol = "";
        truncation_length = 9223372036854775807;
        truncation_symbol = "...";
        only_attached = false;
        always_show_remote = false;
      };

      hostname = {
        ssh_only = true;
        format = lib.concatStrings [
          "[$hostname](bold red)"
        ];
      };

      line_break = {
        disabled = false;
      };
    };
  };

  programs.vim = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    # enableSyntaxHighlighting = true;
    # defaultKeymap = "vim";
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentryFlavor = "curses";
  };

  services.keybase = {
    enable = true;
  };
}
