#!/bin/bash

source $HOME/.cargo/env
eval "$(starship init bash)" 

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles-repo/ --work-tree=$HOME'

alias bat=bat --theme="ansi"

# Lab
alias lab="DOCKER_HOST=ssh://root@lab.dawn.lol docker"
alias lab-compose="DOCKER_HOST=ssh://root@lab.dawn.lol docker-compose"

# Golang
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

# Install fzf
if [ ! -d "$HOME/.fzf" ] 
then
    echo "Installing fzf"

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install
    source ~/.bashrc
fi
export PATH="$HOME/.fzf/bin:$PATH"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# Install zoxide if not already installed.
if [ ! -f "$HOME/.local/bin/zoxide" ]
then
    echo "Installing zoxide"
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi
eval "$(zoxide init bash)"
alias cd='z'

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

alias ls="eza";
alias ll="eza -l";
alias gs="git status";
alias gco="git checkout";

# Disable C-s locking the shell.
if [[ -t 0 && $- = *i* ]]
then
    stty -ixon
fi 


eval "$(mise activate bash)"
. "$HOME/.cargo/env"

# If not present download git completions.
if [ ! -f "$HOME/.git-completion.bash" ]
then

    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi
source ~/.git-completion.bash

__git_complete gco _git_checkout

# ocaml
# Check if opam is installed.
if command -v opam &> /dev/null
then
    eval $(opam env)
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

[ -f "/home/brian/.ghcup/env" ] && source "/home/brian/.ghcup/env" # ghcup-env

unset HISTIGNORE


bind 'set enable-bracketed-paste on'

# ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

export PATH="$HOME/go/bin:$PATH"

# AI tool profile selector
_ai_profile_select() {
  gum choose --header "Choose a profile" "personal" "work"
}

claude() {
  local real_claude
  real_claude="$(type -P claude)"

  if [[ "$(uname -s)" != "Darwin" ]]; then
    "$real_claude" "$@"
    return $?
  fi

  local profile
  profile="$(_ai_profile_select)" || return $?

  local profile_dir="$HOME/.config/claude-profiles/${profile}"

  local args=()
  if gum confirm "Dangerously skip permissions?" --default=No; then
    args+=("--dangerously-skip-permissions")
  fi

  CLAUDE_CONFIG_DIR="${profile_dir}/.claude" \
  DOCKER_HOST="unix://$HOME/.colima/default/docker.sock" \
    "$real_claude" "${args[@]}" "$@"
}

codex() {
  local real_codex
  real_codex="$(type -P codex)"

  if [[ "$(uname -s)" != "Darwin" ]]; then
    "$real_codex" "$@"
    return $?
  fi

  local profile
  profile="$(_ai_profile_select)" || return $?

  local profile_dir="$HOME/.config/claude-profiles/${profile}"

  CODEX_HOME="${profile_dir}/.codex" \
  DOCKER_HOST="unix://$HOME/.colima/default/docker.sock" \
    "$real_codex" "$@"
}

export PATH="$HOME/.local/bin:$PATH"
