OS=$(uname -s)
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

# These are popular installation directories.
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# Nix package manager -- which I've really liked so far!
[[ -e ~/.nix-profile/etc/profile.d/nix.sh ]] && source ~/.nix-profile/etc/profile.d/nix.sh

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

zinit light zpm-zsh/dircolors-material

zinit pack:bgn for if'[[ -z "$SSH_TTY" ]]' firefox-dev

zinit wait lucid for \
    as:null from:gh-r bpick'*.tar.gz' sbin'**/bin/gh' cli/cli \
    OMZL::git.zsh \
    atload"unalias grv" OMZP::git \
    as:null from:gh make'install prefix=$ZPFX' nvie/gitflow \
    as:null from:gh make'install PREFIX=$ZPFX' Fakerr/git-recall \
    as:null from:gh has'asciidoc' \
        atclone'make install prefix=$ZPFX && make install-release-doc prefix=$ZPFX && cp -vf contrib/tig-completion.zsh _tig' atpull'%atclone' \
        jonas/tig

function die() {
    echo "$@"
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
    local git_reset="git reset --keep HEAD~${n}"
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

PS1="READY >" # provide a simple prompt till the theme loads

_atload_starship() {
    export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
}

zinit ice wait'!' lucid from:gh-r atclone'./starship init zsh > init.zsh && ./starship completions zsh > _starship' atpull'%atclone' atload'_atload_starship' src'init.zsh' sbin:starship
zinit load starship/starship

# Time for build tools!
zinit wait lucid for \
    from:gh-r sbin:ninja nocompletions ninja-build/ninja \
    as:null from:gh if'[[ "$OS" != Darwin ]]' has:cmake ver'llvmorg-12.0.1' nocompletions \
        atclone'cmake -S llvm -B build -G Ninja -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb" -DCMAKE_INSTALL_PREFIX=$ZPFX -DCMAKE_BUILD_TYPE=Release && cmake --build build --target install --parallel $(nproc)' \
        atpull'%atclone' \
        llvm/llvm-project

case "$OS" in
    Darwin)
        zinit ice wait lucid from:gh-r bpick'*macos*.dmg' sbin'**/bin/cmake'
        ;;
    *)
        zinit ice wait lucid from:gh-r extract'!' bpick'*linux-x86*.tar.gz' sbin'**/bin/cmake'
        ;;
esac
zinit light Kitware/CMake

_atload_rust() {
    [[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall rust/rustup
    export RUSTUP_HOME=$PWD/rustup
}

zinit wait lucid for \
    rustup id-as'rust/rustup' as:null sbin'bin/*' atload'_atload_rust' light-mode zdharma/null \
    as:completion 'https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/rust/_rust'

if [[ -z "$SSH_TTY" ]]; then
    zinit wait lucid for \
        as:null ver'3.2a' sbin:tmux \
            atclone'./autogen.sh && ./configure --prefix $ZPFX' atpull'%atclone' make \
            tmux/tmux \
        as:null sbin:bin/xpanes greymd/tmux-xpanes \
        id-as'tmuxinator/tmuxinator' gem'!tmuxinator' light-mode zdharma/null \
        as:completion atclone'cp -vf **/tmuxinator.zsh _tmuxinator' atpull'%atclone' 'https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh'
fi

_atload_fzf() {
    if [ ! -z $TMUX ]; then
        if command -v fzf-tmux > /dev/null 2>&1 ; then
            # 2021-06-20 Disabling for now. Kinda prefer inline fzf
            # alias fzf='fzf-tmux -p'
        fi
    fi
}

GO_VERSION="1.16.5"
case "$OS" in
    Darwin)
        GOLANG_URL="https://golang.org/dl/go$GO_VERSION.darwin-amd64.tar.gz"
        ;;
    *)
        GOLANG_URL="https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
        ;;
esac
zinit wait lucid for \
    as:null sbin'**/bin/(go|gofmt)' extract'!' "$GOLANG_URL" \
    OMZP::golang \
    sbin'bin/(fzf|fzf-tmux)' src'shell/key-bindings.zsh' \
        atclone'./install --bin && cp -vf shell/completion.zsh _fzf' atpull'%atclone' atload'_atload_fzf' \
	    junegunn/fzf \
    nocompletions urbainvaes/fzf-marks \
    nocompletions Aloxaf/fzf-tab

case "$OS" in
    Darwin)
        zinit ice wait lucid from:gh-r sbin:sad
        ;;
    *)
        zinit ice wait lucid from:gh-r bpick'*linux*.zip' sbin:sad
        ;;
esac
zinit light ms-jpq/sad

zinit ice wait lucid
zinit light hlissner/zsh-autopair

zinit ice wait:2 lucid from:gh-r mv'delta* -> delta' sbin'delta/delta'
zinit light dandavison/delta

_atload_exa() {
    alias ls='exa -F'
    alias la='exa -a'
    alias ll='exa -l'
    alias lla='exa -a -l'
}

zinit ice wait lucid from:gh-r sbin'bin/exa' \
    atpull'cp -vf man/exa.1 $ZPFX/man/man1 && cp -vf completions/exa.zsh _exa' atclone'%atpull' atload'_atload_exa'
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

zinit ice wait lucid from:gh-r sbin'**/bat' \
    atclone'cp -vf **/bat.1 $ZPFX/man/man1 && cp -vf **/autocomplete/bat.zsh _bat' atpull'%atclone' atload'_atload_bat'
zinit light @sharkdp/bat

_atload_fd() {
}

zinit ice wait lucid from:gh-r sbin'**/fd' \
    atclone'cp -vf **/fd.1 $ZPFX/man/man1 && cp -vf **/autocomplete/_fd _fd' atpull'%atclone' atload'_atload_fd'
zinit light @sharkdp/fd

_atload_ripgrep() {
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git" --no-ignore'
    alias grep='rg --color=auto'
    alias egrep='rg --color=auto'
    alias fgrep='rg --color=auto'
}

zinit ice wait lucid from:gh-r sbin'**/rg' \
    atclone'cp -vf **/doc/rg.1 $ZPFX/man/man1 && cp -vf **/complete/_rg _rg' atpull'%atclone' atload'_atload_ripgrep'
zinit light BurntSushi/ripgrep

zinit ice wait:4 lucid from:gh-r mv'yq* -> yq' sbin:yq atclone'yq shell-completion zsh > _yq'
zinit light mikefarah/yq

_atload_pyenv() {
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
}

_atload_pyenv_virtualenv() {
    eval "$(pyenv virtualenv-init -)"
}

zinit wait lucid for \
    from:gh sbin:bin/pyenv atinit'export PYENV_ROOT="$PWD"; ln -sf $PYENV_ROOT $HOME/.pyenv' atclone'src/configure' atpull'%atclone' make'-C src' atload'_atload_pyenv' pyenv/pyenv \
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
    OMZP::dircycle \
    OMZP::gradle \
    OMZP::jenv \
    OMZP::jsontools \
    OMZP::magic-enter \
    OMZP::node \
    OMZP::npm \
    OMZP::python \
    OMZP::rsync \
    OMZP::safe-paste \
    OMZP::sudo \
    OMZP::urltools \
    OMZP::zsh_reload

zinit load mattberther/zsh-nodenv

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit wait lucid for \
    OMZP::git \
    OMZP::git-extras \
    'https://github.com/bobthecow/git-flow-completion/blob/master/git-flow-completion.zsh'

function _atload_nvim() {
    export MANPAGER='nvim +Man!'
    export EDITOR='nvim'
}

zinit ice wait lucid from:gh nocompletions \
    make'CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$ZPFX install' \
    atload'_atload_nvim'
zinit light neovim/neovim

function _atload_pass() {
    export PASSWORD_STORE_ENABLE_EXTENSIONS=true
}

zinit wait lucid for \
    from'git.zx2c4.com' as:program if'[[ -z "$_ZSHRC_DISABLE_PASS" ]]' \
        atclone'cp src/completion/pass.zsh-completion _pass_completion; cp contrib/dmenu/passmenu $ZPFX/bin/' atpull'%atclone' atload'_atload_pass' \
        make'PREFIX=$ZPFX install' pick'$ZPFX/bin/pass' \
        password-store \
    as:null if'[[ -z "$_ZSHRC_DISABLE_PASS" ]]' \
        make'PREFIX=$ZPFX install' \
        roddhjav/pass-update \
    as:null if'[[ -z "$_ZSHRC_DISABLE_PASS" ]]' \
        make'PREFIX=$ZPFX BASHCOMPDIR=$ZPFX/share/bash-completion/completions install' \
        palortoff/pass-extension-tail \
    as:null if'[[ -z "$_ZSHRC_DISABLE_PASS" ]]' \
        make'PREFIX=$ZPFX BINDIR=$ZPFX/bin BASHCOMPDIR=$ZPFX/share/bash-completion/completions install' \
        rjekker/pass-extension-meta \
    from:gh-r if'[[ -z "$_ZSHRC_DISABLE_PASS" ]]' \
        bpick'*pass*' sbin:docker-credential-pass nocompletions \
        docker/docker-credential-helpers

if [[ -z "$_ZSHRC_DISABLE_EMSDK" ]]; then
    zinit ice wait lucid as:null from:gh sbin:emsdk nocompletions
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
                as:null atclone'PREFIX=$ZPFX ./rebuild -j$(nproc)' atpull'%atclone' nocompletions \
                    mpv-player/mpv-build \
                as:completion 'https://github.com/mpv-player/mpv/blob/master/etc/_mpv.zsh' \
                as:null sbin:ff2mpv atclone'./install.sh' atpull'%atclone' nocompletions \
                    woodruffw/ff2mpv
            ;;
    esac
fi


zinit ice wait lucid as:program from:gh ver:3.0.5 \
    atclone'./autogen.sh && ./configure --prefix=$ZPFX' atpull'%atclone' \
    make'install' pick'$ZPFX/bin/htop' nocompletions
zinit light htop-dev/htop

zinit ice wait lucid from:gh-r sbin:doctl nocompletions
zinit light digitalocean/doctl

LUA_VERSION='5.4.3'
zinit wait lucid for \
    id-as:lua/lua from:gh nocompletions \
        atclone"curl -R -O http://www.lua.org/ftp/lua-$LUA_VERSION.tar.gz && tar zxf lua-$LUA_VERSION.tar.gz" atpull'%atclone' \
        make"-C lua-$LUA_VERSION all test install INSTALL_TOP=$ZPFX" \
        light-mode zdharma/null \
    from:gh-r nocompletions sbin:stylua JohnnyMorganz/StyLua \
    from:gh sbin'bin/**/lua-language-server' nocompletions \
        atclone'(cd 3rd/luamake; ./compile/install.sh) && ./3rd/luamake/luamake rebuild' atpull'%atclone' \
        sumneko/lua-language-server

zinit ice wait lucid from:gh-r as:null sbin'**/mmv' nocompletions
zinit light itchyny/mmv

case "$OS" in
    Darwin)
        zinit ice wait lucid from:gh-r as:null sbin'**/glow' nocompletions
        ;;
    *)
        zinit ice wait lucid from:gh-r as:null bpick'*linux_x86_64*' sbin'**/glow' nocompletions
        ;;
esac
zinit light charmbracelet/glow

autoload -Uz compinit
compinit

zinit cdreplay -q

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
    eval $(keychain --quiet --ignore-missing --eval --gpg2 --agents $KEYCHAIN_AGENTS --inherit any $KEYCHAIN_IDENTITIES 2> /dev/null)
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

function gpg-reset-card() {
    gpg-connect-agent "scd serialno" "learn --force" /bye
}

# Source user-specific configuration.
[[ -f $HOME/.user.zshrc ]] && source $HOME/.user.zshrc
