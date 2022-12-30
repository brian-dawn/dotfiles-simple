#!/bin/bash

source $HOME/.cargo/env
eval "$(starship init bash)" 

# Install pyenv.
if [ ! -d "$HOME/.pyenv" ]
then
    curl https://pyenv.run | bash
    source ~/.bashrc
fi

if [ -n "$(type -t pyenv)" ] && [ "$(type -t pyenv)" = function ]; then
#    "pyenv is already initialized"
    true
else
    if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
fi
export PATH="$HOME/.pyenv/bin:$PATH"


alias config='/usr/bin/git --git-dir=$HOME/.dotfiles-repo/ --work-tree=$HOME'


# Golang
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Install fzf
if [ ! -d "$HOME/.fzf" ] 
then
    echo "Installing fzf"

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install
    source ~/.bashrc
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


export PATH="$HOME/.local/bin:$PATH"

alias ls="exa";
alias ll="exa -l";
alias gs="git status";
alias gco="git checkout";
__git_complete gco _git_checkout


# Disable C-s locking the shell.
if [[ -t 0 && $- = *i* ]]
then
    stty -ixon
fi 


# Flutter
export PATH="$HOME/software/flutter/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

# Load anaconda if present.
[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh



# If not present download git completions.
if [ ! -f "$HOME/.git-completion.bash" ]
then

    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi
source ~/.git-completion.bash

return 0
