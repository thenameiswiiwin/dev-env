# Zsh environment settings
export ZDOTDIR="$HOME/.zsh"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Set PATH to include common local bin directories
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/scripts:$PATH"

# Ensure Homebrew is in PATH
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif [[ -d "$HOME/.linuxbrew" ]]; then
    eval "$($HOME/.linuxbrew/bin/brew shellenv)"
elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Development environment path
export DEV_ENV="${DEV_ENV:-$HOME/dev}"

# Default editor
export EDITOR=nvim
export VISUAL=nvim

# Locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
