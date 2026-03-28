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
chezmoi init --apply https://github.com/YOUR_USER/dotfiles.git
```

### With the bootstrap script

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USER/dotfiles/main/scripts/install.sh | bash
```

### Manual

```bash
git clone https://github.com/YOUR_USER/dotfiles.git ~/.dotfiles
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
worksesh . claude     # Auto-launch agent in agent window
```

Standard layout:
- Window 0: `edit` — Neovim
- Window 1: `agent` — Claude Code / Amp / Codex
- Window 2: `run` — server / test runner

Switch between projects with `prefix + s` (session picker).

## Neovim workflow

Neovim is configured as the primary code review interface for AI-generated changes:

- `<leader>gd` — Open diffview (review what an agent just changed)
- `<leader>gh` — File history for current file
- `<leader>ac` — Toggle Claude Code panel
- `<leader>ab` — Add current buffer to Claude context
- `Ctrl+h/j/k/l` — Navigate seamlessly between tmux panes and Neovim splits

Files auto-reload when agents modify them on disk. `swapfile` is disabled to avoid conflicts.

## Agent workflow

The `30-agents.zsh` module sets up wrappers for all three agents:

```bash
cc        # claude (Claude Code)
cx        # codex (OpenAI Codex CLI)
```

The starship prompt shows which agent is active. Helper functions:

```bash
parallel-agents "task1" "task2" "task3"  # Launch headless agents in tmux
worktree-agent feature-branch [claude]   # Git worktree + agent
```

## Ghostty shaders

Two shaders, both subtle enough for daily use:

- **aurora.glsl** — Slow-moving color wash behind terminal text (Catppuccin palette)
- **cursor-glow.glsl** — Gentle glow around cursor position

Toggle off by commenting out `custom-shader` lines in ghostty config. Hot-reloads on save.

## Customization

Zsh config is modular — drop a `50-myproject.zsh` file into `dot_zshrc.d/` and it auto-sources. Neovim plugins go in `dot_config/nvim/lua/plugins/`. Everything is meant to be forked and tweaked.
