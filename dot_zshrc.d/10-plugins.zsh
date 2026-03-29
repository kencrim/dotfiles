# 10-plugins.zsh — Plugin settings (plugins loaded by sheldon in 00-sheldon.zsh)

# ─── Autosuggestions ──��──────────────────────
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7086"

# ─── fzf-tab ────────────────────────────────
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-min-height 10

# ─── Completions ─────────────────────────────
autoload -Uz compinit && compinit -C

# ─── History substring search ────────────────
# Keybindings are set via sheldon post-hook in plugins.toml
# (ensures widget exists before bindkey runs)

# ─── History settings ────────────────────────
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
