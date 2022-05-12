#!/bin/bash

source $HOME/.cargo/env
eval "$(starship init bash)" 

# Install pyenv.
if [ ! -d "$HOME/.pyenv" ]
then
    curl https://pyenv.run | bash
    source ~/.bashrc
fi
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"


alias config='/usr/bin/git --git-dir=$HOME/.dotfiles-repo/ --work-tree=$HOME'

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

# Disable C-s locking the shell.
if [[ -t 0 && $- = *i* ]]
then
    stty -ixon
fi 




export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
