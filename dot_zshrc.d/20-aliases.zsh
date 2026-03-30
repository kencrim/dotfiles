# 20-aliases.zsh — Common aliases

# ─── Navigation ──────────────────────────────
alias ..="cd .."
alias ...="cd ../.."

if command -v eza &>/dev/null; then
    alias ls="eza"
    alias ll="eza -lah --git"
    alias la="eza -la --git"
    alias lt="eza --tree --level=2"
else
    alias ls="ls -G"
    alias ll="ls -lah"
    alias la="ls -la"
fi

# ─── Git ─────────────────────────────────────
alias g="git"
alias gs="git status -sb"
alias gd="git diff"
alias gds="git diff --staged"
alias gc="git commit"
alias gca="git commit --amend --no-edit"
alias gco="git checkout"
alias gb="git branch --sort=-committerdate"
alias gl="git log --oneline -20"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gwt="git worktree"
alias gwtl="git worktree list"
command -v wt &>/dev/null && eval "$(wt shell-init)"

# ─── Docker ──────────────────────────────────
alias d="docker"
alias dc="docker compose"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"

# ─── tmux ────────────────────────────────────
alias t="tmux"
alias ta="tmux attach -t"
alias tl="tmux list-sessions"
alias tk="tmux kill-session -t"

# ─── Misc ────────────────────────────────────
alias cat="bat --style=plain 2>/dev/null || cat"
alias tree="tree -I 'node_modules|.git|build|dist'"
alias reload="source ~/.zshrc"
