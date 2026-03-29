# dotfiles

Personal terminal environment for agentic coding. Ghostty + tmux + Neovim + zsh, managed with chezmoi.

## What's in here

- **Ghostty** with GLSL shaders (aurora background, cursor glow) and Catppuccin Mocha theme
- **tmux** with session-per-project workflow, Catppuccin status bar, and vim-tmux-navigator
- **Neovim** via LazyVim with claudecode.nvim, diffview.nvim, and Catppuccin Mocha
- **zsh** with modular config, sheldon plugin manager, starship prompt, atuin history, zoxide
- **Git** config with delta (syntax-highlighted diffs)
- **claude-squad** for multi-agent orchestration across git worktrees
- **mise** for unified runtime management (node, python)
- **Brewfile** for declarative package management

## Quick start

```bash
brew install chezmoi
chezmoi init --apply https://github.com/kencrim/dotfiles.git
```

That single command installs all packages (via Brewfile), deploys all configs, and wires up `~/.zshrc`. After it completes:

1. Open a new terminal (or `exec zsh`)
2. Run `tmux` — then press `Ctrl+Space I` to install tmux plugins
3. Run `nvim` to bootstrap LazyVim on first launch

## Layout

```
dotfiles/
├── Brewfile                        # Declarative package manifest
├── .chezmoiignore                  # chezmoi exclusion rules
├── dot_claude-squad/
│   └── config.json                 # claude-squad config
├── dot_config/
│   ├── ghostty/
│   │   ├── config                  # Terminal config (Catppuccin, shaders)
│   │   └── shaders/
│   │       ├── aurora.glsl         # Aurora background animation
│   │       └── cursor-glow.glsl    # Soft cursor glow effect
│   ├── tmux/
│   │   └── tmux.conf               # tmux with vim-tmux-navigator
│   ├── nvim/
│   │   ├── init.lua                # LazyVim bootstrap
│   │   └── lua/
│   │       ├── config/             # options, keymaps, autocmds
│   │       └── plugins/            # colorscheme, editor, ai, disabled
│   ├── git/
│   │   ├── config                  # Git config with delta
│   │   └── ignore                  # Global gitignore
│   ├── sheldon/
│   │   └── plugins.toml            # Zsh plugin declarations
│   ├── mise/
│   │   └── config.toml             # Runtime versions (node, python)
│   ├── starship.toml               # Prompt config
│   └── fastfetch/
│       └── config.jsonc            # System info display
├── dot_zshrc.d/
│   ├── 00-sheldon.zsh              # Plugin manager bootstrap
│   ├── 05-path.zsh                 # PATH and environment setup
│   ├── 10-plugins.zsh              # Plugin settings
│   ├── 20-aliases.zsh              # Aliases (git, docker, tmux)
│   ├── 30-agents.zsh               # Agent wrappers and helpers
│   └── 40-prompt.zsh               # Starship + shell integrations
└── scripts/
    └── install.sh                  # Bootstrap script (non-chezmoi)
```

## The tmux workflow

Each workstream gets its own tmux session. Use `ws` (from [grimoire](https://github.com/kencrim/grimoire)) for agent-managed workstreams, or create sessions manually.

```bash
ws add auth --agent amp --task "Build JWT auth"    # Create a workstream
ws list                                            # Show the DAG
ws send auth "prioritize sessions"                 # Message an agent
ws kill auth                                       # Tear down
```

Key bindings (prefix is `Ctrl+Space`):

| Keys | What it does |
|---|---|
| `prefix + c` | New window |
| `prefix + 1/2/3` | Switch windows |
| `prefix + s` | Session picker (switch between projects) |
| `prefix + S` | Create a new session |
| `prefix + C-c` | Open Claude Code in a new window |
| `prefix + \|` | Split pane horizontally |
| `prefix + -` | Split pane vertically |
| `Ctrl+h/j/k/l` | Navigate between tmux panes and Neovim splits |

## Agent workflow

For multi-agent work, use `claude-squad` — it manages Claude Code instances in isolated git worktrees (one worktree per task, automatic branch creation):

```bash
cs                                       # Launch claude-squad TUI
```

Quick aliases:

```bash
cc        # claude (Claude Code)
aa        # amp
cx        # codex (OpenAI Codex CLI)
cs        # claude-squad
ws        # workstream CLI (grimoire)
```

The starship prompt shows which agent is active.

## Neovim workflow

Neovim is configured as the primary code review interface for AI-generated changes:

- `<leader>gd` — Open diffview (review what an agent just changed)
- `<leader>gh` — File history for current file
- `<leader>ac` — Toggle Claude Code panel
- `<leader>ab` — Add current buffer to Claude context
- `Ctrl+h/j/k/l` — Navigate seamlessly between tmux panes and Neovim splits

Files auto-reload when agents modify them on disk. `swapfile` is disabled to avoid conflicts.

## Ghostty shaders

Two shaders, both subtle enough for daily use:

- **aurora.glsl** — Slow-moving color wash behind terminal text (Catppuccin palette)
- **cursor-glow.glsl** — Gentle glow around cursor position

Toggle off by commenting out `custom-shader` lines in ghostty config. Hot-reloads on save.

## Customization

Zsh config is modular — drop a `50-myproject.zsh` file into `dot_zshrc.d/` and it auto-sources. Neovim plugins go in `dot_config/nvim/lua/plugins/`. Everything is meant to be forked and tweaked.
