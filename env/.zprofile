# XDG Base Directory Specification
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Editor settings
export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim

# Development environment paths
export PERSONAL=$XDG_CONFIG_HOME/personal
export DEV_ENV=${DEV_ENV:-$HOME/dev}

# Detect OS for platform-specific configurations
OS="$(uname -s)"
ARCH="$(uname -m)"

# Initialize Homebrew based on OS and architecture
if [[ "$OS" == "Darwin" ]]; then
    # macOS
    if [[ "$ARCH" == "arm64" ]] && [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"  # Apple Silicon
    elif [[ -f /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"     # Intel
    fi
elif [[ "$OS" == "Linux" ]]; then
    # Linux
    if [[ -d "$HOME/.linuxbrew" ]]; then
        eval "$($HOME/.linuxbrew/bin/brew shellenv)"
    elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
fi

# Helper functions for path management
addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

addToPathFront() {
    if [[ -n "${2:-}" ]] || [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

# Add paths in order of priority (front to back)
addToPathFront "/usr/local/bin"
addToPathFront "/usr/local/sbin"
addToPathFront "$HOME/.local/bin"
addToPathFront "$HOME/.local/scripts"
addToPathFront "/usr/local/opt/lua@5.1/bin"

# Rust
addToPathFront "$HOME/.cargo/bin"

# Node.js
addToPathFront "$HOME/.npm-global/bin"

# Go
if command -v brew >/dev/null 2>&1; then
    export GOROOT="$(brew --prefix go)/libexec"
fi
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

# Python
if [[ -d "$HOME/.python-global-env/bin" ]]; then
    addToPathFront "$HOME/.python-global-env/bin"
fi

if [[ -d "$HOME/.jupyter-env/bin" ]]; then
    addToPathFront "$HOME/.jupyter-env/bin"
fi

# Source all files in personal directory
if [[ -d $PERSONAL ]]; then
    for i in $(find -L "$PERSONAL" -type f 2>/dev/null); do
        source "$i"
    done
fi

# OS-specific configurations
if [[ "$OS" == "Darwin" ]]; then
    # macOS
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
elif [[ "$OS" == "Linux" ]]; then
    # Linux
    export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'
fi
