#!/bin/bash

source $HOME/.cargo/env

eval "$(starship init bash)" 

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



