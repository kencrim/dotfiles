# 40-prompt.zsh — Starship prompt + tool integrations

# ─── Starship prompt ─────────────────────────
eval "$(starship init zsh)"

# ─── Atuin (shell history) ───────────────────
if command -v atuin &> /dev/null; then
    eval "$(atuin init zsh --disable-up-arrow)"
    # Ctrl+R for atuin search, up arrow stays as substring search
fi

# ─── Zoxide (smarter cd) ────────────────────
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# ─── fzf keybindings ────────────────────────
if command -v fzf &> /dev/null; then
    source <(fzf --zsh) 2>/dev/null
fi

# ─── fastfetch on new interactive shell ──────
# Only show on first shell in a terminal (not in tmux splits, subshells, etc.)
if [[ -z "$TMUX" ]] && [[ -z "$FORGE_FASTFETCH_SHOWN" ]]; then
    export FORGE_FASTFETCH_SHOWN=1
    command -v fastfetch &> /dev/null && fastfetch
fi
