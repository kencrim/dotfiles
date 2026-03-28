#!/usr/bin/env bash
# install.sh — Bootstrap the forge dev environment
# Run: curl -fsSL https://raw.githubusercontent.com/USER/forge/main/scripts/install.sh | bash
set -euo pipefail

FORGE_DIR="${HOME}/.forge"
CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}"

echo "═══════════════════════════════════════"
echo "  forge — local dev environment setup"
echo "═══════════════════════════════════════"
echo ""

# ─── Detect OS ───────────────────────────────
OS="$(uname -s)"
case "$OS" in
    Darwin) PKG_MGR="brew" ;;
    Linux)  PKG_MGR="apt" ;;  # Extend for other distros as needed
    *)      echo "Unsupported OS: $OS"; exit 1 ;;
esac

# ─── Install dependencies ───────────────────
echo "→ Installing dependencies via $PKG_MGR..."

if [[ "$PKG_MGR" == "brew" ]]; then
    command -v brew &>/dev/null || {
        echo "  Homebrew not found. Install from https://brew.sh"
        exit 1
    }

    PACKAGES=(tmux starship atuin zoxide fzf fastfetch bat)
    for pkg in "${PACKAGES[@]}"; do
        if ! brew list "$pkg" &>/dev/null; then
            echo "  Installing $pkg..."
            brew install "$pkg"
        else
            echo "  $pkg ✓"
        fi
    done

    # Nerd font
    if ! brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
        echo "  Installing JetBrains Mono Nerd Font..."
        brew install --cask font-jetbrains-mono-nerd-font
    else
        echo "  JetBrains Mono Nerd Font ✓"
    fi

    # Ghostty
    if ! brew list ghostty &>/dev/null 2>&1; then
        echo "  Installing Ghostty..."
        brew install --cask ghostty
    else
        echo "  Ghostty ✓"
    fi
fi

# ─── Clone repo if not already present ───────
if [[ ! -d "$FORGE_DIR" ]]; then
    echo ""
    echo "→ Cloning forge repo..."
    git clone https://github.com/YOUR_USER/forge.git "$FORGE_DIR"
else
    echo ""
    echo "→ forge repo already at $FORGE_DIR"
fi

# ─── Symlink configs ────────────────────────
echo ""
echo "→ Linking configuration files..."

mkdir -p "$CONFIG_DIR"

# Ghostty
mkdir -p "$CONFIG_DIR/ghostty"
ln -sfn "$FORGE_DIR/dot_config/ghostty/config" "$CONFIG_DIR/ghostty/config"
ln -sfn "$FORGE_DIR/dot_config/ghostty/shaders" "$CONFIG_DIR/ghostty/shaders"
echo "  Ghostty config ✓"

# tmux
mkdir -p "$CONFIG_DIR/tmux"
ln -sfn "$FORGE_DIR/dot_config/tmux/tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"
echo "  tmux config ✓"

# Starship
ln -sfn "$FORGE_DIR/dot_config/starship.toml" "$CONFIG_DIR/starship.toml"
echo "  Starship config ✓"

# Fastfetch
mkdir -p "$CONFIG_DIR/fastfetch"
ln -sfn "$FORGE_DIR/dot_config/fastfetch/config.jsonc" "$CONFIG_DIR/fastfetch/config.jsonc"
echo "  Fastfetch config ✓"

# ─── Add bin to PATH ────────────────────────
chmod +x "$FORGE_DIR/bin/"*
if ! echo "$PATH" | grep -q "$FORGE_DIR/bin"; then
    echo ""
    echo "→ Add to your .zshrc:"
    echo "  export PATH=\"$FORGE_DIR/bin:\$PATH\""
fi

# ─── Add zshrc module sourcing ───────────────
ZSHRC_LINE="for f in $FORGE_DIR/dot_zshrc.d/*.zsh; do source \"\$f\"; done"
if ! grep -q "dot_zshrc.d" ~/.zshrc 2>/dev/null; then
    echo ""
    echo "→ Add to your .zshrc (or replace its contents):"
    echo ""
    echo "  export PATH=\"$FORGE_DIR/bin:\$PATH\""
    echo "  $ZSHRC_LINE"
fi

# ─── Install TPM ────────────────────────────
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    echo ""
    echo "→ Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "  TPM ✓ (press prefix + I inside tmux to install plugins)"
else
    echo ""
    echo "  TPM ✓"
fi

echo ""
echo "═══════════════════════════════════════"
echo "  Done. Open Ghostty and run: tmux"
echo "  Then press Ctrl+Space + I to install"
echo "  tmux plugins."
echo "═══════════════════════════════════════"
