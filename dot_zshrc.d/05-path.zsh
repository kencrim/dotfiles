# 05-path.zsh — PATH and environment setup

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# mise — unified runtime manager (replaces nvm, pyenv, rbenv)
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Go
export PATH="$PATH:$HOME/go/bin"

# Maestro
export PATH="$PATH:$HOME/.maestro/bin"

# Local bin (~/.local/bin is standard for Claude Code, uv, etc.)
export PATH="$HOME/.local/bin:$PATH"

# Dotfiles bin (chezmoi deploys to ~/bin)
export PATH="$HOME/bin:$PATH"
