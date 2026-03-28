#!/usr/bin/env bash
# install.sh — Bootstrap dotfiles
# Run: curl -fsSL https://raw.githubusercontent.com/YOUR_USER/dotfiles/main/scripts/install.sh | bash
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}"

echo "═══════════════════════════════════════"
echo "  dotfiles — environment setup"
echo "═══════════════════════════════════════"
echo ""

# ─── Detect OS ───────────────────────────────
OS="$(uname -s)"
case "$OS" in
    Darwin) PKG_MGR="brew" ;;
    Linux)  PKG_MGR="apt" ;;
    *)      echo "Unsupported OS: $OS"; exit 1 ;;
esac

# ─── Install dependencies ───────────────────
echo "-> Installing dependencies via $PKG_MGR..."

if [[ "$PKG_MGR" == "brew" ]]; then
    command -v brew &>/dev/null || {
        echo "  Homebrew not found. Install from https://brew.sh"
        exit 1
    }

    # Clone repo first so we can use the Brewfile
    if [[ ! -d "$DOTFILES_DIR" ]]; then
        echo ""
        echo "-> Cloning dotfiles repo..."
        git clone https://github.com/YOUR_USER/dotfiles.git "$DOTFILES_DIR"
    else
        echo ""
        echo "-> dotfiles repo already at $DOTFILES_DIR"
    fi

    echo "-> Installing packages from Brewfile..."
    brew bundle --file="$DOTFILES_DIR/Brewfile" --no-lock
fi

# ─── Symlink configs ────────────────────────
echo ""
echo "-> Linking configuration files..."

mkdir -p "$CONFIG_DIR"

# Ghostty
mkdir -p "$CONFIG_DIR/ghostty"
ln -sfn "$DOTFILES_DIR/dot_config/ghostty/config" "$CONFIG_DIR/ghostty/config"
ln -sfn "$DOTFILES_DIR/dot_config/ghostty/shaders" "$CONFIG_DIR/ghostty/shaders"
echo "  Ghostty config ✓"

# tmux
mkdir -p "$CONFIG_DIR/tmux"
ln -sfn "$DOTFILES_DIR/dot_config/tmux/tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"
echo "  tmux config ✓"

# Starship
ln -sfn "$DOTFILES_DIR/dot_config/starship.toml" "$CONFIG_DIR/starship.toml"
echo "  Starship config ✓"

# Fastfetch
mkdir -p "$CONFIG_DIR/fastfetch"
ln -sfn "$DOTFILES_DIR/dot_config/fastfetch/config.jsonc" "$CONFIG_DIR/fastfetch/config.jsonc"
echo "  Fastfetch config ✓"

# Neovim
ln -sfn "$DOTFILES_DIR/dot_config/nvim" "$CONFIG_DIR/nvim"
echo "  Neovim config ✓"

# Sheldon
mkdir -p "$CONFIG_DIR/sheldon"
ln -sfn "$DOTFILES_DIR/dot_config/sheldon/plugins.toml" "$CONFIG_DIR/sheldon/plugins.toml"
echo "  Sheldon config ✓"

# mise
mkdir -p "$CONFIG_DIR/mise"
ln -sfn "$DOTFILES_DIR/dot_config/mise/config.toml" "$CONFIG_DIR/mise/config.toml"
echo "  mise config ✓"

# Git
mkdir -p "$CONFIG_DIR/git"
ln -sfn "$DOTFILES_DIR/dot_config/git/config" "$CONFIG_DIR/git/config"
ln -sfn "$DOTFILES_DIR/dot_config/git/ignore" "$CONFIG_DIR/git/ignore"
echo "  Git config ✓"

# ─── Add bin to PATH ────────────────────────
chmod +x "$DOTFILES_DIR/bin/"*

# ─── zshrc setup ────────────────────────────
ZSHRC_LINE="for f in $DOTFILES_DIR/dot_zshrc.d/*.zsh; do source \"\$f\"; done"
if ! grep -q "dot_zshrc.d" ~/.zshrc 2>/dev/null; then
    echo ""
    echo "-> Add to your .zshrc (or replace its contents):"
    echo ""
    echo "  $ZSHRC_LINE"
fi

# ─── Install TPM ────────────────────────────
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    echo ""
    echo "-> Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "  TPM ✓ (press prefix + I inside tmux to install plugins)"
else
    echo ""
    echo "  TPM ✓"
fi

# ─── mise setup ─────────────────────────────
if command -v mise &>/dev/null; then
    echo ""
    echo "-> Setting up runtimes via mise..."
    mise install
    echo "  mise runtimes ✓"
fi

echo ""
echo "═══════════════════════════════════════"
echo "  Done. Open Ghostty and run: tmux"
echo ""
echo "  Next steps:"
echo "  1. Press Ctrl+Space + I to install tmux plugins"
echo "  2. Run 'nvim' to bootstrap LazyVim"
echo "  3. Run 'sheldon lock' to install shell plugins"
echo "═══════════════════════════════════════"
