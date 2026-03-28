# 30-agents.zsh — Agentic coding tool config
# Aliases and environment for Claude Code, Amp, and Codex CLI

# ─── Agent aliases ───────────────────────────
alias cc="claude"
alias cch="claude --print"                       # Headless / one-shot mode
alias amp="amp"
alias cx="codex"

# ─── Environment ─────────────────────────────
# Anthropic — set your API key in ~/.config/forge/secrets.env or via 1Password
[[ -f ~/.config/forge/secrets.env ]] && source ~/.config/forge/secrets.env

# Track which agent is "active" in this shell (used by starship prompt)
# Set by the agent wrapper functions below
export FORGE_ACTIVE_AGENT=""

# ─── Agent wrapper functions ─────────────────
# These set the active agent indicator and launch the tool

function claude() {
    export FORGE_ACTIVE_AGENT="claude"
    command claude "$@"
    export FORGE_ACTIVE_AGENT=""
}

function amp() {
    export FORGE_ACTIVE_AGENT="amp"
    command amp "$@"
    export FORGE_ACTIVE_AGENT=""
}

function codex() {
    export FORGE_ACTIVE_AGENT="codex"
    command codex "$@"
    export FORGE_ACTIVE_AGENT=""
}

# ─── Parallel agent sessions ────────────────
# Launch N Claude Code headless agents on different tasks
# Usage: forge-parallel "task1" "task2" "task3"
function forge-parallel() {
    local session_name="forge-agents"
    tmux new-session -d -s "$session_name" -n "agent-0" 2>/dev/null || true

    local i=0
    for task in "$@"; do
        if [[ $i -eq 0 ]]; then
            tmux send-keys -t "${session_name}:agent-0" "claude --print '$task'" Enter
        else
            tmux new-window -t "$session_name" -n "agent-${i}"
            tmux send-keys -t "${session_name}:agent-${i}" "claude --print '$task'" Enter
        fi
        ((i++))
    done

    echo "Launched $i agent(s) in tmux session '$session_name'"
    echo "Attach with: tmux attach -t $session_name"
}

# ─── Git worktree + agent helper ─────────────
# Create a worktree and immediately open an agent in it
# Usage: forge-worktree feature-branch [claude|amp|codex]
function forge-worktree() {
    local branch="${1:?Usage: forge-worktree <branch> [agent]}"
    local agent="${2:-claude}"
    local worktree_path="../${branch}"

    git worktree add "$worktree_path" -b "$branch" 2>/dev/null || \
        git worktree add "$worktree_path" "$branch"

    cd "$worktree_path"
    echo "Worktree created at $worktree_path"
    echo "Launching $agent..."
    "$agent"
}
