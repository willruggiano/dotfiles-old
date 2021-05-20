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
    OMZL::git.zsh \
    atload"unalias grv" OMZP::git

PS1="READY >" # provide a simple prompt till the theme loads

#zinit wait'!' lucid for \
#    OMZL::prompt_info_functions.zsh \
#    OMZT::robbyrussell

export STARSHIP_CONFIG=$HOME/.config/starship.toml

_atload_starship() {
    eval "$(starship init zsh)"
}

zinit ice wait'!' lucid from"gh-r" as"program" atload"_atload_starship"
zinit load starship/starship

_atload_fzf() {

    if [ ! -z $TMUX ]; then
        if builtin command -v fzf-tmux > /dev/null 2>&1 ; then
            alias fzf='fzf-tmux -p'
        fi
    fi
}

zinit ice wait lucid from"gh" as"program" \
    make"install" \
    atclone"cp shell/completion.zsh _fzf" \
    atpull"%atclone" \
    atload"_atload_fzf" \
    pick"bin/(fzf|fzf-tmux)"
zinit light junegunn/fzf

_atload_exa() {
    alias ls='exa'
    alias la='exa -a'
    alias ll='exa -l'
    alias lla='exa -a -l'
}

zinit ice wait lucid from"gh-r" as"program" atload"_atload_exa" pick"bin/exa"
zinit light ogham/exa

_atload_bat() {
    export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2>/dev/null | head -30\' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),ctrl-p:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
    export FZF_ALT_C_OPTS="--preview 'bat {}'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="--select-1 --exit-0 $FZF_DEFAULT_OPTS"
    alias bat='bat --paging=never'
    alias batp='bat --paging=auto'
}

zinit ice wait lucid from"gh-r" as"program" atload"_atload_bat" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

_atload_fd() {
}

zinit ice wait lucid from"gh-r" as"program" atload"_atload_fd" mv"fd* -> fd" pick"fd/fd" nocompletions
zinit light sharkdp/fd

_atload_ripgrep() {
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git" --no-ignore'
    alias grep='rg --color=auto'
    alias egrep='rg --color=auto'
    alias fgrep='rg --color=auto'
}  

zinit ice wait lucid from"gh-r" as"program" atload"_atload_ripgrep" mv"ripgrep* -> rg" pick"rg/rg" nocompletions
zinit light BurntSushi/ripgrep

zinit wait lucid for \
    as"completion" OMZP::cargo/_cargo \
    OMZP::dircycle \
    OMZP::golang \
    OMZP::gradle \
    OMZP::jenv \
    OMZP::jsontools \
    OMZP::keychain \
    OMZP::magic-enter \
    OMZP::node \
    OMZP::npm \
    OMZP::pip \
    OMZP::python \
    as"completion" OMZP::ripgrep/_ripgrep \
    OMZP::rsync \
    as"completion" OMZP::rust/_rust \
    as"completion" OMZP::rustup/_rustup \
    OMZP::safe-paste \
    OMZP::sudo \
    OMZP::themes \
    OMZP::tmux \
    OMZP::tmuxinator \
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

autoload -Uz compinit
compinit

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

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
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':prompt:pure:git:stash' show yes
# Use keychain to manage gpg and ssh identifies.
zstyle :omz:plugins:keychain agents gpg,ssh
# Autoload additional identities.
zstyle :omz:plugins:keychain identities id_github id_rsa
zstyle :omz:plugins:keychain options --quiet

autoload colors
colors

export PATH=$HOME/.cargo/bin:$PATH

export MANPAGER='nvim +Man!'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
export ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
export ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
export ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BEAM

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

# Source user-specific configuration.
source $HOME/.user.zshrc

[ "${DISPLAY}" ] && [ -z "${TMUX}" ] && tmux new -A

