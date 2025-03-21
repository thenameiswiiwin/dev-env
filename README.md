# Cross-Platform Development Environment Setup

A comprehensive set of scripts and configurations to automate the setup and maintenance of a consistent, powerful development environment across macOS (Intel/Apple Silicon) and major Linux distributions.

## 🚀 Features

- **Universal Compatibility**: Works seamlessly on macOS (Intel and Apple Silicon) and Linux (Ubuntu, Debian, Kali, Arch, Alpine)
- **Homebrew-first Approach**: Utilizes Homebrew as the primary package manager with intelligent fallbacks
- **Modular Design**: Individual installation scripts with clean separation of concerns
- **Smart Installation**: Idempotent execution allows scripts to be run repeatedly without issues
- **Dry Run Support**: Preview changes without applying them using the `--dry` flag
- **Intelligent Error Handling**: Detailed error messages with automatic fallback mechanisms
- **Automatic Backups**: Creates backups of existing configurations before modifications
- **Detailed Logging**: Color-coded status indicators for clear progress tracking
- **Shell Integration**: Seamless integration with Zsh, including Oh My Zsh and plugins
- **Tool Configuration**: Pre-configured development tools including Neovim, tmux, Git, Docker, and more
- **Project Workflow**: Integrated project management, database operations, and Git workflow tools

## 📋 Component Overview

### Core Tools

- **Neovim**: Modern, extensible code editor with LSP support and custom plugins
- **tmux**: Terminal multiplexer with productivity-focused configuration
- **Zsh**: Shell with Oh My Zsh, auto-suggestions, and syntax highlighting
- **Git**: Version control with enhanced configuration and workflow tools
- **Docker**: Container platform with helper scripts and multi-distribution environments
- **Window Management**: Rectangle (macOS) or i3 (Linux) for efficient window control

### Programming Languages

- **Node.js**: JavaScript/TypeScript development environment with npm/pnpm
- **Python**: Python development with virtual environments and common tools
- **Rust**: Rust language and Cargo package manager
- **Go**: Go language environment with tools and configuration
- **PHP**: PHP with Composer and Laravel support

### Productivity Tools

- **tmux-sessionizer**: Intelligent tmux session management
- **Docker Development Environments**: Cross-distribution testing environments
- **Project Management**: Scripts for project creation and navigation

## 🛠️ Installation

### Prerequisites

- Bash 4.0+ (pre-installed on macOS and most Linux distributions)
- Git (will be installed if not present)
- Internet connection for downloading packages and tools

### Quick Setup

To bootstrap a new system, run:

```bash
curl -fsSL https://raw.githubusercontent.com/thenameiswiiwin/dev-env/main/setup | bash
```

Or clone the repository and run the setup script:

```bash
git clone https://github.com/thenameiswiiwin/dev-env.git $HOME/dev
cd $HOME/dev
./setup
```

### Dry Run Mode

To preview changes without applying them, use the `--dry` flag:

```bash
./setup --dry
```

## 📂 Directory Structure

```
dev/
├── .github/workflows    # GitHub Actions for CI
├── dev-env              # Environment configuration script
├── diagnose             # Diagnostic tool for troubleshooting
├── env/                 # Environment configuration files
│   ├── .config/         # App-specific configurations
│   │   ├── ghostty/     # Ghostty terminal configuration
│   │   ├── i3/          # i3 window manager configuration
│   │   ├── nvim/        # Neovim editor configuration (submodule)
│   │   ├── personal/    # Personal configuration overrides
│   │   ├── rectangle/   # Rectangle window manager configuration
│   │   └── tmux/        # tmux configuration
│   ├── .local/          # Local binaries and scripts
│   │   ├── bin/         # Executable scripts
│   │   └── scripts/     # Utility scripts
│   └── ...              # Shell configuration files
├── init                 # Git submodule initialization script
├── run                  # Main execution script for run scripts
├── runs/                # Individual installation scripts
│   ├── dev              # Development tools
│   ├── docker           # Docker and container tools
│   ├── ghostty          # Ghostty terminal
│   ├── go               # Go language
│   ├── libs             # Core utility libraries
│   ├── neovim           # Neovim editor
│   ├── node             # Node.js and related tools
│   ├── php              # PHP and Composer
│   ├── python           # Python and pip
│   ├── rust             # Rust and cargo
│   ├── tmux             # Tmux terminal multiplexer
│   ├── window-manager   # OS-specific window managers
│   └── zsh              # Zsh shell configuration
├── setup                # Initial bootstrap script
├── tmux-sessionizer/    # Tmux session management tool (submodule)
├── update               # Environment update script
└── utilities            # Core utility functions
```

## 📝 Usage

### Installing Specific Tools

To install specific tools, use the `run` script:

```bash
./run [tool_name]
```

For example, to install Neovim:

```bash
./run neovim
```

### Updating the Environment

To update all installed tools:

```bash
./update
```

### Troubleshooting

If you encounter problems, run the diagnostic tool:

```bash
./diagnose
```

## 🔧 Core Components in Detail

### Utility Scripts

The `utilities` script provides core functions used throughout the environment:

- Color-coded logging
- Command existence checking
- Package installation with fallbacks
- File backup functionality
- Execution with dry-run support

### Runner System

The `run` script manages the execution of individual installation scripts:

- Executes scripts in the `runs/` directory
- Supports filtering by name
- Provides dry-run mode
- Handles errors and dependencies

### Environment Configuration

The `dev-env` script manages symbolic links and configuration files:

- Links configuration files from repository to system
- Manages dotfiles and application configs
- Creates necessary directories
- Backs up existing configurations

## 🛠️ Tool-Specific Features

### Neovim Configuration

- LSP integration for multiple languages
- Treesitter for advanced syntax highlighting
- Telescope for fuzzy finding
- Custom keybindings and plugins
- Git integration
- Testing framework

### tmux Setup

- Custom key bindings for productivity
- Status line configuration
- Mouse support
- Plugin management
- Session management via tmux-sessionizer

### Zsh Configuration

- Oh My Zsh integration
- Syntax highlighting
- Auto-suggestions
- Completion improvements
- Custom aliases and functions

### Docker Development Environments

The repository includes a complete Docker-based development environment:

- Multiple Linux distributions (Ubuntu, Debian, Alpine, Arch, Kali)
- Shared configuration across environments
- Development tools pre-installed
- Docker Compose for orchestration

## 📱 macOS-Specific Features

- Rectangle window management
- Homebrew optimization
- macOS system settings
- Ghostty terminal configuration
- Dock customization

## 🐧 Linux-Specific Features

- i3 window manager configuration
- X11 settings
- Rofi application launcher
- Polybar status bar
- Display management

## 🔄 Git Workflow

The repository includes tools for Git workflow optimization:

- Feature branching
- Hotfix management
- Release workflow
- Branch cleanup
- GitHub integration

## 🧠 Intelligent Project Management

The `project` script provides tools for project management:

- Project creation from templates
- Directory organization
- Project type detection
- Quick navigation
- Development environment setup

## 🔄 tmux-sessionizer

A powerful tmux session manager with features like:

- Intelligent project detection
- Smart session switching
- Custom session templating
- Fuzzy directory finding
- Project-specific layouts

## 📄 Configuration Customization

### Personal Configuration

You can customize the environment by:

1. Editing configuration files in the `env/` directory
2. Creating your own scripts in the `runs/` directory
3. Adding personal configurations to `$HOME/personal`
4. Using `*.local` files for machine-specific settings

### Machine-Specific Configuration

For machine-specific overrides:

1. Create a `.local` version of any configuration file
2. Place custom configurations in `$HOME/personal`
3. Use the `personal/` directory within `.config`

## 📊 Compatibility

| OS             | Architecture  | Status           |
| -------------- | ------------- | ---------------- |
| macOS Ventura+ | Apple Silicon | ✅ Full support  |
| macOS Ventura+ | Intel         | ✅ Full support  |
| Ubuntu 22.04+  | x86_64/ARM64  | ✅ Full support  |
| Debian 11+     | x86_64/ARM64  | ✅ Full support  |
| Arch Linux     | x86_64        | ✅ Full support  |
| Alpine Linux   | x86_64        | ✅ Basic support |
| Kali Linux     | x86_64        | ✅ Basic support |

## 💻 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-tool`)
3. Make your changes
4. Test with `./run --dry [tool_name]`
5. Commit your changes (`git commit -am 'Add new tool'`)
6. Push to the branch (`git push origin feature/new-tool`)
7. Create a new Pull Request

## 📝 License

Copyright (c) 2025 Huy Nguyen
