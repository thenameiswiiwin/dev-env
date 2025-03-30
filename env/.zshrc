# Oh My Zsh installation path
export ZSH="$HOME/.oh-my-zsh"
export TMUX_THEME=dawn

# Theme selection
ZSH_THEME="amuse"

# Oh My Zsh plugins
plugins=(
  git
  history
  sudo
  copypath
  docker
  npm
  colored-man-pages
)

ZSH_THEME_GIT_PROMPT_PREFIX="git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Detect OS and architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

# Handle architecture-specific paths and fix insecure directories
if [[ "$OS" == "Darwin" ]]; then
    # Detect Homebrew prefix based on architecture
    if [[ "$ARCH" == "arm64" ]]; then
        # Apple Silicon Mac
        HOMEBREW_PREFIX="/opt/homebrew"
    else
        # Intel Mac
        HOMEBREW_PREFIX="/usr/local"
    fi

    # Fix insecure directories BEFORE loading Oh My Zsh
    autoload -Uz compaudit
    if compaudit &>/dev/null; then
        # Fix permissions on insecure directories
        for dir in $(compaudit); do
            echo "Fixing insecure directory permissions: $dir"
            chmod go-w "$dir" 2>/dev/null || sudo chmod go-w "$dir" 2>/dev/null
        done
    fi
fi

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Source profile if it exists
[[ -f "$ZDOTDIR/.zprofile" ]] && source "$ZDOTDIR/.zprofile"

# Load plugin configurations with architecture awareness
if [[ "$OS" == "Darwin" && -d "$HOMEBREW_PREFIX" ]]; then
    # Use architecture-specific Homebrew paths
    for plugin in "zsh-autosuggestions" "zsh-syntax-highlighting"; do
        plugin_path="$HOMEBREW_PREFIX/share/${plugin}/${plugin}.zsh"
        if [[ -f "$plugin_path" ]]; then
            source "$plugin_path"
        fi
    done

    # Add Homebrew completions to FPATH
    if [[ -d "$HOMEBREW_PREFIX/share/zsh-completions" ]]; then
        FPATH="$HOMEBREW_PREFIX/share/zsh-completions:$FPATH"
    fi
    
    if [[ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]]; then
        FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"
    fi
else
    # Fall back to checking multiple paths for non-macOS or if Homebrew prefix not found
    for plugin in "zsh-autosuggestions" "zsh-syntax-highlighting"; do
        for plugin_path in \
            "/usr/local/share/${plugin}/${plugin}.zsh" \
            "/opt/homebrew/share/${plugin}/${plugin}.zsh" \
            "/home/linuxbrew/.linuxbrew/share/${plugin}/${plugin}.zsh" \
            "$HOME/.linuxbrew/share/${plugin}/${plugin}.zsh" \
            "/usr/share/${plugin}/${plugin}.zsh" \
            "$HOME/.oh-my-zsh/custom/plugins/${plugin}/${plugin}.zsh"
        do
            [[ -f "$plugin_path" ]] && source "$plugin_path"
        done
    done

    # Add non-architecture specific paths to FPATH
    if command -v brew &>/dev/null; then
        FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
    fi
fi

# Add Docker completions to FPATH if they exist
if [[ -d "$HOME/.docker/completions" ]]; then
    FPATH="$HOME/.docker/completions:$FPATH"
fi

# Initialize completions - only do this ONCE with proper flags
autoload -Uz compinit
compinit -i -d "$ZDOTDIR/.zcompdump"

# Configure Zsh completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colored completion
zstyle ':completion:*' rehash true                         # Automatically find new executables

# Autosuggestion settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7C6F64"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# History settings
HISTSIZE=50000
SAVEHIST=10000
HISTFILE="$ZDOTDIR/.zsh_history"
setopt HIST_IGNORE_SPACE     # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS      # Don't save duplicate lines
setopt SHARE_HISTORY         # Share history between sessions
setopt HIST_IGNORE_ALL_DUPS  # Delete old entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS     # Do not display duplicates when searching
setopt HIST_SAVE_NO_DUPS     # Don't write duplicate entries
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks

# Optimize shell behavior
unsetopt beep
unsetopt correct
setopt no_flow_control
setopt auto_cd               # Change directory without cd
setopt auto_pushd            # Push directories onto the stack
setopt pushd_ignore_dups     # Don't push duplicates onto the stack

# Utility function to find and kill process by port
findandkill() {
    if [[ -z "$1" ]]; then
        echo "Usage: findandkill PORT_NUMBER"
        return 1
    fi

    local pid=$(lsof -t -i:"$1" 2>/dev/null)
    if [[ -z "$pid" ]]; then
        echo "No process found on port $1"
        return 1
    fi

    echo "Killing process $pid on port $1"
    kill -9 "$pid"
}

# Common aliases
alias v='nvim'
alias vim='nvim'
alias ll='ls -lah'
alias l='ls -lah'
alias hist='history | grep'
alias port='sudo lsof -i'
alias ps='ps aux | grep'
alias kill_port=findandkill
alias bu='brew cleanup && brew update && brew upgrade && brew cleanup && brew doctor'
alias bo='brew outdated'

# OS-specific configurations
if [[ "$OS" == "Darwin" ]]; then
    # macOS-specific aliases
    alias ls='ls -G'  # Colorized ls on macOS
    alias dsclean='sudo find / -name ".DS_Store" -exec rm -v {} \;'
    alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
    alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
    alias flush='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder && echo "DNS cache flushed"'
elif [[ "$OS" == "Linux" ]]; then
    # Linux-specific aliases
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias open='xdg-open'

    # Set clipboard commands based on what's available
    if command -v xclip &> /dev/null; then
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
    elif command -v xsel &> /dev/null; then
        alias pbcopy='xsel --clipboard --input'
        alias pbpaste='xsel --clipboard --output'
    fi
fi

# Load custom configurations from personal directory
if [[ -d "$XDG_CONFIG_HOME/personal" ]]; then
    for file in $(find -L "$XDG_CONFIG_HOME/personal" -type f 2>/dev/null); do
        source "$file"
    done
fi

# Add key binding for tmux-sessionizer if it exists
if command -v tmux-sessionizer &>/dev/null; then
    bindkey -s "^f" "tmux-sessionizer\n"
fi

# Final PATH adjustments
export PATH="$HOME/.local/bin:$PATH"

# Handle tmux alias with architecture awareness
if [[ "$OS" == "Darwin" && -d "$HOMEBREW_PREFIX" ]]; then
    # Use architecture-aware path for tmux
    if [[ -f "$HOMEBREW_PREFIX/bin/tmux" ]]; then
        unalias tmux 2>/dev/null
        alias tmux="command $HOMEBREW_PREFIX/bin/tmux -2"
        unalias t 2>/dev/null
        alias t='tmux'
    fi
else
    # Try the standard path first
    if [[ -f "/usr/local/bin/tmux" ]]; then
        unalias tmux 2>/dev/null
        alias tmux='command /usr/local/bin/tmux -2'
        unalias t 2>/dev/null
        alias t='tmux'
    # Otherwise find tmux in PATH
    elif command -v tmux &>/dev/null; then
        tmux_path=$(command -v tmux)
        unalias tmux 2>/dev/null
        alias tmux="command $tmux_path -2"
        unalias t 2>/dev/null
        alias t='tmux'
    fi
fi
