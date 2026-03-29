# 30-agents.zsh — Agentic coding tool config
# Aliases and environment for Claude Code, Amp, and Codex CLI

# ─── Agent aliases ───────────────────────────
alias cc="claude"
alias cch="claude --print"                       # Headless / one-shot mode
alias aa="amp"
alias cx="codex"
alias cs="claude-squad"

# ─── Environment ─────────────────────────────
# Anthropic — set your API key in ~/.config/dotfiles/secrets.env or via 1Password
[[ -f ~/.config/dotfiles/secrets.env ]] && source ~/.config/dotfiles/secrets.env

# Track which agent is "active" in this shell (used by starship prompt)
# Set by the agent wrapper functions below
export DOTFILES_ACTIVE_AGENT=""

# ─── Agent wrapper functions ─────────────────
# These set the active agent indicator and launch the tool

function claude() {
    export DOTFILES_ACTIVE_AGENT="claude"
    command claude "$@"
    export DOTFILES_ACTIVE_AGENT=""
}

function amp() {
    export DOTFILES_ACTIVE_AGENT="amp"
    command amp "$@"
    export DOTFILES_ACTIVE_AGENT=""
}

function codex() {
    export DOTFILES_ACTIVE_AGENT="codex"
    command codex "$@"
    export DOTFILES_ACTIVE_AGENT=""
}

# ─── Agent Teams (experimental) ─────────────
# Uncomment to enable Claude Code's native multi-agent tmux integration
# Known issues: race conditions, pane-base-index conflicts, idle teammates
# export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
