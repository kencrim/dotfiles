# 20-aliases.zsh — Common aliases

# ─── Navigation ──────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls --color=auto"
alias ll="ls -lah"
alias la="ls -la"

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

# ─── Kubernetes ──────────────────────────────
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgd="kubectl get deployments"
alias kl="kubectl logs -f"
alias kx="kubectx"
alias kn="kubens"

# ─── Docker ──────────────────────────────────
alias d="docker"
alias dc="docker compose"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"

# ─── tmux ────────────────────────────────────
alias t="tmux"
alias ta="tmux attach -t"
alias tl="tmux list-sessions"
alias tk="tmux kill-session -t"
alias ws="worksesh"

# ─── Misc ────────────────────────────────────
alias cat="bat --style=plain 2>/dev/null || cat"
alias tree="tree -I 'node_modules|.git|build|dist'"
alias reload="source ~/.zshrc"
