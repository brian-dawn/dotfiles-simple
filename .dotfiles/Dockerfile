FROM golang:1.23.3-bookworm


RUN apt-get update && apt-get install -y \
    git \
    vim \
    curl \
    cmake \
    gcc \
    build-essential \
    pkg-config \
    libssl-dev \
    tmux \
    && apt-get clean

# Install rustup and set up Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && . $HOME/.cargo/env && rustup component add rust-analyzer
 
# Use cargo to install Rust-based utilities
RUN . $HOME/.cargo/env \
    && cargo install zoxide \
    && cargo install exa \
    && cargo install du-dust \
    && cargo install starship


# Clone and build Helix editor from source
RUN git clone https://github.com/helix-editor/helix.git $HOME/helix \
    && cd $HOME/helix \
    && . $HOME/.cargo/env \
    && cargo install --path helix-term --locked \
    && mkdir -p ~/.config/helix \
    && mv runtime ~/.config/helix/runtime \
    && rm -fr $HOME/helix


# Symlink helix binary to make it available globally
RUN ln -s $HOME/.cargo/bin/hx /usr/local/bin/hx

RUN git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf \
    && $HOME/.fzf/install --all

RUN git clone --bare https://github.com/brian-dawn/dotfiles-simple.git $HOME/.dotfiles-repo

# Install NodeJS stuff.
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash \
    && bash -c "source $HOME/.bashrc && nvm install --lts && nvm use --lts && npm install -g npm"


# Install Python stuff.
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

COPY config /usr/local/bin/config

# Install LSPs.
RUN bash -c "source $HOME/.bashrc                                            \
    && npm i -g @astrojs/language-server                                     \
    && npm i -g bash-language-server                                         \
    &&  npm install -g dockerfile-language-server-nodejs                     \
    && npm install -g @microsoft/compose-language-service                    \
    && go install golang.org/x/tools/gopls@latest                            \
    && go install github.com/go-delve/delve/cmd/dlv@latest                   \
    && go install golang.org/x/tools/cmd/goimports@latest                    \
    && go install github.com/nametake/golangci-lint-langserver@latest        \
    && go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest \
    && npm i -g vscode-langservers-extracted                                 \
    "
    



RUN config checkout -f

RUN config config status.showUntrackedFiles no

RUN bash -c "source $HOME/.bashrc"

WORKDIR $HOME

CMD ["bash", "-c", "cd $HOME && exec /bin/bash"]

