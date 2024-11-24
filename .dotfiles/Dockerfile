FROM ubuntu:24.04

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


# Install Python stuff.
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

COPY config /usr/local/bin/config


RUN config checkout -f

RUN config config status.showUntrackedFiles no

CMD ["/bin/bash"]
