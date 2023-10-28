#!/bin/bash

source $HOME/.cargo/env
eval "$(starship init bash)" 

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

# Use ripgrep for fzf and ignore common macOS folders.
export FZF_DEFAULT_COMMAND="rg --files --glob '!~/Library/*' --glob '!/System/*' --glob '!/Applications/*' --glob '!/Library/*' --glob '!/Users/Shared/*'"

# Ignore files and folders specified in .gitignore, node_modules, folders beginning with a dot, __pycache__ folders, and common macOS folders in Ctrl-T.
export FZF_CTRL_T_COMMAND="rg --files --no-ignore-vcs --glob '!./.*/*' --glob '!*/node_modules/*' --glob '!**/__pycache__/*' --glob '!~/Library/*' --glob '!/System/*' --glob '!/Applications/*' --glob '!/Library/*' --glob '!/Users/Shared/*'"


# Goto file, helpful in conjunction with C-T
gt() {
    if [ -f "$1" ]; then  # Check if file exists
        cd "$(dirname "$1")"  # Change directory to the parent directory of the file
    else
        echo "File does not exist: $1"
    fi
}



export PATH="$HOME/.local/bin:$PATH"

alias ls="exa";
alias ll="exa -l";
alias gs="git status";
alias gco="git checkout";


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

__git_complete gco _git_checkout


source $(tamago activate)

# ocaml
# Check if opam is installed.
if command -v opam &> /dev/null
then
    source $(opam env)
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

[ -f "/home/brian/.ghcup/env" ] && source "/home/brian/.ghcup/env" # ghcup-env
