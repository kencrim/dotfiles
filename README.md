# dotfiles

Personal terminal environment for agentic coding. Ghostty + tmux + Neovim + zsh, managed with chezmoi.

## What's in here

- **Ghostty** with GLSL shaders (aurora background, cursor glow) and Catppuccin Mocha theme
- **tmux** with session-per-project workflow, Catppuccin status bar, and vim-tmux-navigator
- **Neovim** via LazyVim with claudecode.nvim, diffview.nvim, and Catppuccin Mocha
- **zsh** with modular config, sheldon plugin manager, starship prompt, atuin history, zoxide
- **Git** config with delta (side-by-side syntax-highlighted diffs)
- **mise** for unified runtime management (node, python)
- **Brewfile** for declarative package management
- Scripts for parallel agentic coding sessions across tmux

## Quick start

### With chezmoi (recommended)

```bash
brew install chezmoi
chezmoi init --apply https://github.com/kencrim/dotfiles.git
```

### With the bootstrap script

```bash
curl -fsSL https://raw.githubusercontent.com/kencrim/dotfiles/main/scripts/install.sh | bash
```

### Manual

```bash
git clone https://github.com/kencrim/dotfiles.git ~/.dotfiles
brew bundle --file=~/.dotfiles/Brewfile
# Then symlink configs (see scripts/install.sh for paths)
```

After install, add to your `~/.zshrc`:

```bash
for f in ~/.dotfiles/dot_zshrc.d/*.zsh; do source "$f"; done
```

## Layout

```
dotfiles/
├── Brewfile                        # Declarative package manifest
├── .chezmoiignore                  # chezmoi exclusion rules
├── dot_claude-squad/
│   └── config.json                # claude-squad defaults (dangerously-skip-permissions)
├── dot_config/
│   ├── ghostty/
│   │   ├── config                  # Terminal config (Catppuccin, shaders)
│   │   └── shaders/
│   │       ├── aurora.glsl         # Aurora background animation
│   │       └── cursor-glow.glsl   # Soft cursor glow effect
│   ├── tmux/
│   │   └── tmux.conf              # tmux with vim-tmux-navigator
│   ├── nvim/
│   │   ├── init.lua               # LazyVim bootstrap
│   │   └── lua/
│   │       ├── config/            # options, keymaps, autocmds
│   │       └── plugins/           # colorscheme, editor, ai, disabled
│   ├── git/
│   │   ├── config                 # Git config with delta
│   │   └── ignore                 # Global gitignore
│   ├── sheldon/
│   │   └── plugins.toml           # Zsh plugin declarations
│   ├── mise/
│   │   └── config.toml            # Runtime versions (node, python)
│   ├── starship.toml              # Prompt config
│   └── fastfetch/
│       └── config.jsonc           # System info display
├── dot_zshrc.d/
│   ├── 00-sheldon.zsh             # Plugin manager bootstrap
│   ├── 05-path.zsh               # PATH and environment setup
│   ├── 10-plugins.zsh            # Plugin settings
│   ├── 20-aliases.zsh            # Aliases (git, docker, tmux)
│   ├── 30-agents.zsh             # Agent wrappers and helpers
│   └── 40-prompt.zsh             # Starship + shell integrations
├── bin/
│   └── worksesh                   # tmux session-per-project script
└── scripts/
    └── install.sh                 # Bootstrap script
```

## The tmux workflow

Each project gets its own tmux session. `worksesh` handles creation:

```bash
worksesh              # Use current directory
worksesh ~/code/vesta # Specify a path
worksesh -s           # Also launch claude-squad
```

Claude is always one key away via popups — no dedicated window needed:

| Keys | What it does |
|---|---|
| `prefix + y` | Summon/dismiss Claude as a floating overlay (persists in background) |
| `prefix + Y` | Kill Claude popup session (fresh start) |
| `prefix + u` | Open claude-squad popup for multi-agent management |
| `prefix + s` | Session picker (switch between projects) |

For multi-agent work, use `claude-squad` (`cs`) — it creates worktrees and Claude instances per task automatically.

## Neovim workflow

Neovim is configured as the primary code review interface for AI-generated changes:

- `<leader>gd` — Open diffview (review what an agent just changed)
- `<leader>gh` — File history for current file
- `<leader>ac` — Toggle Claude Code panel
- `<leader>ab` — Add current buffer to Claude context
- `Ctrl+h/j/k/l` — Navigate seamlessly between tmux panes and Neovim splits

Files auto-reload when agents modify them on disk. `swapfile` is disabled to avoid conflicts.

## Agent workflow

The primary multi-agent workflow uses `claude-squad`, which manages Claude Code instances in isolated git worktrees:

```bash
cs                                       # Launch claude-squad TUI
worktree-agent feature-branch [claude]   # Manual: git worktree + single agent
```

Quick aliases:

```bash
cc        # claude (Claude Code)
cx        # codex (OpenAI Codex CLI)
cs        # claude-squad
```

The starship prompt shows which agent is active. Agent Teams (experimental) can be enabled by uncommenting the line in `~/.zshrc.d/30-agents.zsh`.

## Ghostty shaders

Two shaders, both subtle enough for daily use:

- **aurora.glsl** — Slow-moving color wash behind terminal text (Catppuccin palette)
- **cursor-glow.glsl** — Gentle glow around cursor position

Toggle off by commenting out `custom-shader` lines in ghostty config. Hot-reloads on save.

## Customization

Zsh config is modular — drop a `50-myproject.zsh` file into `dot_zshrc.d/` and it auto-sources. Neovim plugins go in `dot_config/nvim/lua/plugins/`. Everything is meant to be forked and tweaked.
