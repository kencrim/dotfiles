# 30-agents.zsh — Agentic coding tool config
# Aliases and environment for Claude Code, Amp, and Codex CLI

# ─── Agent aliases ───────────────────────────
alias cc="claude"
alias cch="claude --print"                       # Headless / one-shot mode
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

# ─── Git worktree + agent helper ─────────────
# Create a worktree and immediately open an agent in it
# Usage: worktree-agent feature-branch [claude|amp|codex]
function worktree-agent() {
    local branch="${1:?Usage: worktree-agent <branch> [agent]}"
    local agent="${2:-claude}"
    local worktree_path="../${branch}"

    git worktree add "$worktree_path" -b "$branch" 2>/dev/null || \
        git worktree add "$worktree_path" "$branch"

    cd "$worktree_path"
    echo "Worktree created at $worktree_path"
    echo "Launching $agent..."
    "$agent"
}
