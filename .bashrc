echo 'Loading the core...'

# load the core stuff
for file in $STUFF_HOME/.{path,exports,aliases,functions}; do
  [[ -r "$file" ]] && source "$file"
done
unset file


force_bashrc_source && {
    echo 'Authenticating...'
    # refresh expired Kerberos ticket
    check_kerb
    # refresh expired Midway token
    check_midway
   # ensure we are logged into lastpass
    check_lastpass
}


# We do this every time.
echo 'Initializing the environment...'
force_bashrc_source && {
    # make sure our various cli tools are up to date
    toolbox update --check
}
# initialize all the envsssss
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(nodenv init -)"
eval "$(jenv init -)"
eval "$(goenv init -)"
source "$HOME/.cargo/env"
# two more things for goenv
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
# nvm setup (even though we prefer nodenv to nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



force_bashrc_source && {
    echo 'Configuring remote repositories...'
    # setup some CodeArtifact stuff
    goshawk_npm_init shared  # Amazon shared npm repository
    goshawk_pypi_init
}


echo 'Customizing the user experience...'
# now for ux
for file in ${STUFF_HOME}/.{bindings,completions,fzf,prompt,iterm2_shell_integration.bash}; do
    [[ -r "$file" ]] && source "$file"
done
unset file

# extras last. last!
[[ -r ${STUFF_HOME}/.extra ]] && source ${STUFF_HOME}/.extra

# start tmux on every gui shell login
[ "${DISPLAY}" ] && [ -z "${TMUX}" ] && {
    echo 'Entering TMUX mode...'
#    tmux new -A
}

