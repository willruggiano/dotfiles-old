OS=$(uname -s)

# This is a popular installation directory.
export PATH=$HOME/.local/bin:$PATH

[[ -f $HOME/.user.before.zshrc ]] && source $HOME/.user.before.zshrc

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk


# Most themes use this option
setopt promptsubst

zinit wait lucid for \
    from:gh-r as:program bpick'*.tar.gz' pick'**/bin/gh' cli/cli \
    OMZL::git.zsh \
    atload"unalias grv" OMZP::git \
    as:program from:gh make'install prefix=$ZPFX' nvie/gitflow

zinit ice from:gh as:program ver:3.2 atclone'./autogen.sh && ./configure' atpull'%atclone' make pick:tmux
zinit light tmux/tmux

zinit ice wait:1 lucid from:gh as:program pick'bin/xpanes'
zinit light greymd/tmux-xpanes

PS1="READY >" # provide a simple prompt till the theme loads

_atload_starship() {
    export STARSHIP_CONFIG=$HOME/.config/starship.toml
    eval "$(starship init zsh)"
}

zinit ice wait'!' lucid from:gh-r as:program atload"_atload_starship"
zinit load starship/starship

_atload_fzf() {
    if [ ! -z $TMUX ]; then
        if builtin command -v fzf-tmux > /dev/null 2>&1 ; then
            alias fzf='fzf-tmux -p'
        fi
    fi
}

zinit wait lucid for \
    as:program pick'**/bin/(go|gofmt)' extract'!' 'https://golang.org/dl/go1.16.5.linux-amd64.tar.gz' \
    as:program from:gh pick:'bin/(fzf|fzf-tmux)' \
        atclone'./install --bin && cp shell/completion.zsh _fzf' atpull'%atclone' \
	    junegunn/fzf

zinit ice wait lucid from:gh-r as:program pick:sad
zinit light ms-jpq/sad

zinit ice wait lucid
zinit light hlissner/zsh-autopair

zinit ice wait:2 lucid from:gh-r as:program mv'delta* -> delta' pick'delta/delta'
zinit light dandavison/delta

_atload_exa() {
    alias ls='exa -F'
    alias la='exa -a'
    alias ll='exa -l'
    alias lla='exa -a -l'
}

zinit ice wait lucid from:gh-r as:program atload"_atload_exa" pick"bin/exa"
zinit light ogham/exa

_atload_bat() {
    export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2>/dev/null | head -30\' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),ctrl-p:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute(echo {+} | pbcopy)'"
    export FZF_ALT_C_OPTS="--preview 'bat {}'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="--select-1 --exit-0 $FZF_DEFAULT_OPTS"
    alias bat='bat --paging=never'
    alias batp='bat --paging=auto'
    alias cat='bat'
}

zinit ice wait lucid from"gh-r" as"program" atload"_atload_bat" mv"bat* -> bat" pick"bat/bat"
zinit light @sharkdp/bat

_atload_fd() {
}

zinit ice wait lucid from"gh-r" as"program" atload"_atload_fd" mv"fd* -> fd" pick"fd/fd" nocompletions
zinit light @sharkdp/fd

_atload_ripgrep() {
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git" --no-ignore'
    alias grep='rg --color=auto'
    alias egrep='rg --color=auto'
    alias fgrep='rg --color=auto'
}  

zinit ice wait lucid from"gh-r" as"program" atload"_atload_ripgrep" mv"ripgrep* -> rg" pick"rg/rg" nocompletions
zinit light BurntSushi/ripgrep

_atload_yq() {
    eval "$(yq shell-completion zsh)"
}

zinit ice wait:4 lucid from:gh-r as:program atload'_atload_yq' mv'yq* -> yq' pick:yq
zinit light mikefarah/yq

_atload_pyenv() {
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
}

_atload_pyenv_virtualenv() {
    eval "$(pyenv virtualenv-init -)"
}

zinit wait lucid for \
    from:gh as:command pick:bin/pyenv atinit'export PYENV_ROOT="$PWD"; ln -sf $PYENV_ROOT $HOME/.pyenv' atclone'src/configure' atpull'%atclone' make'-C src' atload'_atload_pyenv' pyenv/pyenv \
    from:gh as:null atinit'ln -sf ~/.zinit/plugins/pyenv---pyenv-virtualenv $(pyenv root)/plugins/pyenv-virtualenv' atload'_atload_pyenv_virtualenv' pyenv/pyenv-virtualenv

_atload_rbenv() {
    export RBENV_ROOT="$HOME/.zinit/plugins/rbenv---rbenv"
    export PATH="$RBENV_ROOT/bin:$PATH"
    eval "$(rbenv init - zsh)"
    ln -sf $(rbenv root) $HOME/.rbenv
}

zinit wait lucid for \
    from:gh as:null atclone'src/configure' atpull'%atclone' make'-C src' atload'_atload_rbenv' rbenv/rbenv \
    from:gh as:null atclone'PREFIX=$ZPFX ./install.sh' atpull'%atclone' rbenv/ruby-build

zinit wait lucid for \
    as:completion OMZP::cargo/_cargo \
    as:completion OMZP::rust/_rust \
    as:completion OMZP::rustup/_rustup

zinit wait lucid for \
    OMZP::dircycle \
    OMZP::golang \
    OMZP::gradle \
    OMZP::jenv \
    OMZP::jsontools \
    OMZP::magic-enter \
    OMZP::node \
    OMZP::npm \
    OMZP::python \
    as:completion OMZP::ripgrep/_ripgrep \
    OMZP::rsync \
    OMZP::safe-paste \
    OMZP::sudo \
    OMZP::ubuntu \
    OMZP::urltools \
    OMZP::zsh_reload
#
zinit load mattberther/zsh-nodenv
#
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
#
zinit ice depth=1
zinit load jeffreytse/zsh-vi-mode
#
zinit wait lucid for \
    urbainvaes/fzf-marks \
    'https://github.com/junegunn/fzf/tree/master/shell/completion.zsh' \
    'https://github.com/junegunn/fzf/tree/master/shell/key-bindings.zsh'

zinit wait lucid for \
    OMZP::git \
    OMZP::git-extras \
    'https://github.com/bobthecow/git-flow-completion/blob/master/git-flow-completion.zsh'

function _atload_nvim() {
    export MANPAGER='nvim +Man!'
    export EDITOR='nvim'
}

case "$OS" in
    Darwin)
        zinit ice wait from:gh-r ver:nightly as:program \
            mv'nvim-* -> nvim' bpick'*macos*' pick'nvim/bin/nvim' \
            atload'_atload_nvim'
        ;;
    *)
        zinit ice wait lucid from:gh-r ver:nightly as:program \
            mv'nvim-* -> nvim' bpick'*linux*' pick'nvim/bin/nvim' \
            atload'_atload_nvim'
        ;;
esac
zinit light neovim/neovim

function _atload_pass() {
    export PASSWORD_STORE_ENABLE_EXTENSIONS=true
}

zinit wait lucid for \
    from'git.zx2c4.com' as:program \
        atclone'cp src/completion/pass.zsh-completion _pass_completion; cp contrib/dmenu/passmenu $ZPFX/bin/' atpull'%atclone' atload'_atload_pass' \
        make'PREFIX=$ZPFX install' pick'$ZPFX/bin/pass' \
        password-store \
    as:null make'PREFIX=$ZPFX LIBDIR=$ZPFX/lib BASHCOMPDIR=$ZPFX/share/bash-completion/completions install' tadfisher/pass-otp \
    as:null make'PREFIX=$ZPFX install' roddhjav/pass-update \
    as:null make'PREFIX=$ZPFX BASHCOMPDIR=$ZPFX/share/bash-completion/completions install' palortoff/pass-extension-tail \
    as:null make'PREFIX=$ZPFX BINDIR=$ZPFX/bin BASHCOMPDIR=$ZPFX/share/bash-completion/completions install' rjekker/pass-extension-meta

if [[ -z "$_ZSHRC_DISABLE_EMSDK" ]]; then
    zinit ice wait lucid from:gh as:program pick:emsdk nocompletions
    zinit light emscripten-core/emsdk
fi

if [[ -z "$SSH_TTY" ]]; then
    case "$OS" in
        Darwin)
            # On macOS we use install mpv through homebrew.
            ;;
        *)
            # N.B. Requires lua5.1 (package manager) and youtube-dl (pip)
            # Qutebrowser will need: update-alternatives --install /usr/local/bin/mpv mpv $ZPFX/bin/mpv 100
            zinit wait lucid for \
                as:program pick'$ZPFX/bin/mpv' \
                    atclone'PREFIX=$ZPFX ./rebuild -j$(nproc)' atpull'%atclone' \
                    nocompletions \
                    mpv-player/mpv-build \
                as:completion 'https://github.com/mpv-player/mpv/blob/master/etc/_mpv.zsh'
            ;;
    esac
fi

case "$OS" in
    Darwin)
        zinit ice wait lucid as:program from:gh-r bpick'*macos*.dmg' pick:bin/cmake
        ;;
    *)
        zinit ice wait lucid as:program from:gh-r extract'!' bpick'*linux-x86*.tar.gz' pick'**/bin/cmake'
        ;;
esac
zinit light Kitware/CMake

autoload -Uz compinit
compinit

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

if command -v fuck > /dev/null; then
    eval "$(thefuck --alias)"
else
    echo 'fuck: not found; skipping set up'
fi

# Completion settings
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':prompt:pure:git:stash' show yes

#### Keychain / GPG / SSH ####
KEYCHAIN_AGENTS="${KEYCHAIN_AGENTS:-gpg}"
if pgrep gpg-agent > /dev/null; then
    export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1"
fi
if command -v keychain > /dev/null; then
    eval $(keychain --quiet --ignore-missing  --eval --gpg2 --agents $KEYCHAIN_AGENTS --inherit any $KEYCHAIN_IDENTITIES)
fi
if pgrep gpg-agent > /dev/null; then
    export GPG_TTY=$TTY
fi

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

export PATH=$HOME/.cargo/bin:$PATH

export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
export ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
export ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
export ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BEAM

function encrypt() {
    local out="$1.$(date +%s).enc"
    gpg --encrypt --armor --output $out -r wmruggiano@gmail.com "$1" && echo "$1 -> $out"
}

function decrypt() {
    local out=$(echo "$1" | rev | cut -c16- | rev)
    gpg --decrypt --output $out "$1" && echo "$1 -> $out"
}

# Source user-specific configuration.
[[ -f $HOME/.user.zshrc ]] && source $HOME/.user.zshrc

[ "$DISPLAY" ] && [ -z "$TMUX" ] && tmux new -A


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
