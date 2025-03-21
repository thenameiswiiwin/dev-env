# Cross-Platform Development Environment Setup

A comprehensive set of scripts to automate the setup and maintenance of a development environment across macOS (Intel/Silicon) and major Linux distributions (Ubuntu, Debian, Kali, Arch, Alpine).

## Features

- **Universal Compatibility**: Works seamlessly on macOS (Intel and Apple Silicon) and Linux (Ubuntu, Debian, Kali, Arch, Alpine)
- **Homebrew-first Approach**: Uses Homebrew as the primary package manager with intelligent fallbacks
- **Modular Design**: Individual scripts for specific development tools with clean separation of concerns
- **Smart Installation**: Idempotent execution allows scripts to be run repeatedly without issues
- **Dry Run Support**: Preview changes without applying them using the `--dry` flag
- **Intelligent Error Handling**: Detailed error messages with fallback mechanisms
- **Backup Creation**: Automatic backups of existing configurations for safety
- **Detailed Logging**: Color-coded status indicators for clear progress tracking
- **Shell Integration**: Seamless integration with Zsh, including Oh My Zsh and plugins
- **Tool Configuration**: Pre-configured development tools including Neovim, tmux, Git, Docker, and more
- **Project Workflow**: Project management, database operations, and Git workflow helpers

## System Requirements

- macOS 10.15+ (Catalina or higher) or Linux distribution (Ubuntu 20.04+, Debian 11+, Arch, Alpine, Kali)
- Bash 4.0+ (pre-installed on macOS and most Linux distributions)
- Internet connection for downloading packages and tools

## Directory Structure

```
dev/
├── .github/workflows    # GitHub Actions workflows for CI
├── dev-env              # Environment configuration script
├── diagnose             # Diagnostic tool for troubleshooting
├── env/                 # Environment configuration files
│   ├── .config/         # App-specific configurations
│   ├── .local/          # Local binaries and scripts
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
├── tmux-sessionizer/    # Tmux session management tool
├── update               # Environment update script
└── utilities            # Core utility functions
```

## Installation

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

## Usage

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

## Component Descriptions

### Core Scripts

- **utilities**: Core utility functions used by all scripts
- **run**: Main script to execute individual installation scripts
- **setup**: Bootstrap script for setting up a new system
- **update**: Script to update the installed environment
- **diagnose**: Diagnostic tool to troubleshoot issues
- **dev-env**: Environment configuration script
- **init**: Git submodule initialization script

### Installation Scripts

- **libs**: Core utility libraries (ripgrep, jq, fzf, etc.)
- **zsh**: Zsh shell with Oh My Zsh and plugins
- **neovim**: Neovim text editor
- **tmux**: Terminal multiplexer with custom configuration
- **rust**: Rust language and cargo
- **python**: Python with virtual environments and common tools
- **node**: Node.js, npm, and frontend tools
- **go**: Go language and tools
- **php**: PHP with Composer
- **docker**: Docker and container tools
- **window-manager**: Rectangle (macOS) or i3 (Linux)
- **dev**: Development tools and Git configuration
- **ghostty**: Ghostty terminal emulator (macOS)

### Utility Scripts

- **project**: Project management
- **db-utils**: Database operations
- **docker-helpers**: Docker container management
- **git-workflow**: Git workflow optimization
- **check-updates**: System update checker
- **clean-system**: System maintenance and cleanup
- **install-fonts**: Font installation helper

## Customization

### Personal Configuration

You can customize the environment by:

1. Editing configuration files in the `env/` directory
2. Creating your own scripts in the `runs/` directory
3. Adding personal configurations to `$HOME/personal`

### Shell Configuration

The default shell is configured as Zsh with the following features:

- Oh My Zsh with customizable themes
- Syntax highlighting and autosuggestions
- Intelligent command completion
- Convenient aliases and functions
- History management
- Integration with development tools

## Troubleshooting

If you encounter issues:

1. Run `./diagnose` to check the system state
2. Check log output for errors
3. Try running specific scripts with `--dry` flag to see what would change
4. Ensure dependencies are installed and paths are correctly set
5. Look for specific error messages and verify permissions

## License

MIT License

Copyright (c) 2025 Huy Nguyen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
