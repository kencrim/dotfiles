# 10-plugins.zsh — Shell plugins (loaded via zinit Turbo mode)

# Syntax highlighting (load first for correct binding)
zinit light zsh-users/zsh-syntax-highlighting

# Autosuggestions from history
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7086"

# fzf-tab: fzf-powered completion menu
zinit light Aloxaf/fzf-tab
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-min-height 10

# Completions
zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit -C

# History substring search
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# History settings
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
