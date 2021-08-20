{ pkgs, lib, ... }:

let
  username = "bombadil";
  homedir = "/home/${username}";

  unstable = import <unstable> { };

  colorscheme = "tokyonight";
  nerdfonts = pkgs.nerdfonts;
  font = {
    package = nerdfonts;
    name = "JetBrainsMono";
    size = 12;
  };

  dirs = {
    configs = ../../dotfiles-old;
  };
in
{
  home = {
    username = username;
    homeDirectory = homedir;
    stateVersion = "21.05";

    packages = with pkgs; [
      # Fonts
      font-awesome_5
      nerdfonts

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
      file
      git
      gitflow
      git-crypt
      jq
      paperkey
      pinentry-curses
      pre-commit
      ranger
      ripgrep
      speedtest-cli
      thefuck
      tig
      unzip
      wget
      xclip
      yq
      yubikey-manager
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

  programs.home-manager = {
    enable = true;
    path = "...";
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

  programs.command-not-found = {
    enable = true;
  };

  programs.exa = {
    enable = true;
    enableAliases = false;
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
    defaultCommand = "rg --files --hidden --glob \"!.git\" --no-ignore ";
    defaultOptions = [
      "--no-mouse"
      "--height 50%"
      "-1"
      "--reverse"
      "--multi"
      "--preview='[[ \\$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2>/dev/null | head -30\'"
      "--preview-window='right:hidden:wrap'"
      "--bind='f3:execute(bat --style=numbers {} || less -f {}),ctrl-p:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept'"
    ];
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--preview 'bat {}'" ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [
      "--select-1"
      "--exit-0"
    ];
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
      init = {
        defaultBranch = "main";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      merge.tool = "nvim";
      mergetool = {
        keepBackup = false;
        nvim = {
          cmd = "nvim -f -c \"Gdiffsplit!\" $MERGED";
        };
      };
      user = {
        signingkey = "79303BEC95097CB6";
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
            block = "speedtest";
            interval = 1800;
            format = "{ping}{speed_down}{speed_up}";
          }
          {
            block = "disk_space";
            path = "/";
            info_type = "used";
            unit = "GB";
            format = "{icon} {used}/{total} ({available} free)";
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
            block = "battery";
            interval = 10;
            format = "{percentage} {time}";
          }
          {
            block = "time";
            interval = 60;
            format = "%a %m/%d %R";
          }
        ];
        icons = "awesome5";
        theme = "plain";
      };
    };
  };

  programs.kitty = {
    enable = true;

    settings = {
      include = "${dirs.configs}/kitty/kitty_tokyonight_storm.conf";

      bold_font = "auto";
      bold_italic_font = "auto";
      italic_font = "auto";

      disable_ligatures = "never";
      # dynamic_background_opacity = true;
      enable_audio_bell = "no";
      # scrollback_pager = "${pkgs.neovim-nightly}/bin/nvim -c \"set nonumber nolist showtabline=0 foldcolumn=0\" -c \"autocmd TermOpen * normal G\" -c \"silent write /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer - \"";
      symbol_map = "U+f101-U+f208 nonicons";
      sync_to_monitor = "no";
    };

    font = font;
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
      ninja
      nixpkgs-fmt
      nodePackages.prettier
      openssl
      python-language-server
      ripgrep
      rnix-lsp
      rustfmt
      unstable.stylua
      sumneko-lua-language-server
      tree-sitter
      yapf
    ];
    extraConfig = ''
      lua <<EOF
      ${(import (dirs.configs + "/nvim/init.lua.nix"))}
      EOF
    '';
  };

  programs.nix-index = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-audit exts.pass-update ]);
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
    enableCompletion = true;

    dotDir = ".config/zsh";

    plugins = with pkgs; [
      {
        name = "fast-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zdharma";
          repo = "fast-syntax-highlighting";
          rev = "817916dfa907d179f0d46d8de355e883cf67bd97";
          sha256 = "0m102makrfz1ibxq8rx77nngjyhdqrm8hsrr9342zzhq1nf4wxxc";
        };
      }
      {
        name = "magic-enter";
        src = fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7a4f4ad91e1f937b36a54703984b958abe9da4b8";
          sha256 = "1p43x3sx54h4vgbaa4iz3j1yj4d0qcnxlcq9c2z4q6j7021gjbvi";
        };
        file = "plugins/magic-enter/magic-enter.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "9d003fc02dbaa6db06e6b12e8c271398478e0b5d";
          sha256 = "0s4xj7yv75lpbcwl4s8rgsaa72b41vy6nhhc5ndl7lirb9nl61l7";
        };
      }
      {
        name = "fzf-marks";
        src = fetchFromGitHub {
          owner = "urbainvaes";
          repo = "fzf-marks";
          rev = "f5c986657bfee0a135fd14277eea857d58ea8cdc";
          sha256 = "11n33kx1v9mdgklhz7mkr673vln27nl02lyscybgc29fchwxfn8k";
        };
      }
      {
        name = "fzf-tab";
        src = fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "89a33154707c09789177a893e5a8ebbb131d5d3d";
          sha256 = "1g8011ldrghbw5ibchsp0p93r31cwyx2r1z5xplksd779jw79wdx";
        };
      }
      {
        name = "material-colors";
        src = fetchFromGitHub {
          owner = "zpm-zsh";
          repo = "material-colors";
          rev = "47cbf2d955220cddc4d3e3845999f22ef270c90a";
          sha256 = "1g2dwl9siihcc0ixidfbsw99ywv2xd3v68kq270j2g3l1j2z59zn";
        };
      }
      {
        name = "clipboard";
        src = fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7a4f4ad91e1f937b36a54703984b958abe9da4b8";
          sha256 = "1p43x3sx54h4vgbaa4iz3j1yj4d0qcnxlcq9c2z4q6j7021gjbvi";
        };
        file = "lib/clipboard.zsh";
      }
      {
        name = "forgit";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "9f3a4239205b638b8c535220bfec0b1fbca2d620";
          sha256 = "1w29ryc4l9pz60xbcwk0czxnhmjjh8xa6amh60whcapbsm174ssz";
        };
      }
    ];

    initExtra = ''
      eval $(thefuck --alias)

      # Completion settings
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
      zstyle ':completion:*:default' menu select=2
      zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
      zstyle ':completion:*:warnings' format '%F{RED}No matches for:%F{YELLOW} %d'$DEFAULT
      zstyle ':completion:*:options' description 'yes'
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':completion:*:git-checkout:*' sort false
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*' list-separator '-->'
      zstyle ':completion:*:manuals' separate-sections true
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
      zstyle ':prompt:pure:git:stash' show yes

      autoload colors
      colors

      setopt hist_ignore_dups
      setopt hist_find_no_dups
      setopt share_history
      setopt noauto_cd
      setopt auto_pushd
      setopt pushd_ignore_dups
      setopt pushd_to_home
      setopt auto_param_slash
      setopt auto_param_keys
      setopt extended_glob

      function encrypt() {
          local out="$1.$(date +%s).enc"
          gpg --encrypt --armor --output $out -r wmruggiano@gmail.com "$1" && echo "$1 -> $out"
      }
      
      function decrypt() {
          local out=$(echo "$1" | rev | cut -c16- | rev)
          gpg --decrypt --output $out "$1" && echo "$1 -> $out"
      }
      
      function gpg-reset-card() {
          gpg-connect-agent "scd serialno" "learn --force" /bye
      }

      function git-turtle() {
          local n=""
          local branch=""
          local dryrun=false
          for a in "$@"; do
          case "$a" in
              -n)
                  shift; n="$1"; shift
                  ;;
              -b)
                  shift; branch="$1"; shift
                  ;;
              --dryrun)
                  shift; dryrun=true
                  ;;
          esac
          done
          [[ -z $n ]] || [[ -z $branch ]] && die '-n and -b|--branch are required'
          local git_reset="git reset --keep HEAD~$n"
          local git_check="git checkout -t -b $branch"
          local git_pick="git cherry-pick ..HEAD@{2}"
          if $dryrun; then
              echo "+ $git_reset"
              echo "+ $git_check"
              echo "+ $git_pick"
          else
              eval "$git_reset && $git_check && $git_pick"
          fi
      }
    '';

    shellAliases = with pkgs; {
      bat = "${bat}/bin/bat --paging=never";
      batp = "${bat}/bin/bat --paging=auto";
      cat = "${bat}/bin/bat";
      grep = "${ripgrep}/bin/rg --color=auto";
      hm = "home-manager";
      ls = "${exa}/bin/exa -F";
      la = "${exa}/bin/exa -a";
      ll = "${exa}/bin/exa -l";
      lla = "${exa}/bin/exa -al";
      lt = "${exa}/bin/exa --tree";
      tree = "${exa}/bin/exa --tree";
    };
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
