# forge

A local dev environment for agentic coding with Claude Code, Amp, and Codex CLI.

Ghostty + tmux + zsh, managed with chezmoi. Some nice shaders. Nothing deranged.

## What's in here

- **Ghostty** config with GLSL shaders (aurora background, cursor trail) and Catppuccin theme
- **tmux** config with session-per-project workflow, Catppuccin status bar, and agent-aware pane indicators
- **zsh** config (modular, split into `~/.zshrc.d/`) with zinit, starship prompt, atuin history, zoxide
- **Starship** prompt showing git, k8s context, active agent tool, and current directory
- **fastfetch** config for a clean system info display on shell start
- **Scripts** for managing parallel agentic coding sessions across tmux

## Prerequisites

```
brew install ghostty tmux zsh starship atuin zoxide fzf fastfetch
brew install --cask font-jetbrains-mono-nerd-font
```

For the coding agents (install whichever you use):
```
# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# Amp (Sourcegraph)
curl -fsSL https://ampcode.com/install.sh | bash

# OpenAI Codex CLI
npm i -g @openai/codex
```

## Install with chezmoi

```bash
chezmoi init --apply https://github.com/YOUR_USER/forge.git
```

Or manually symlink:
```bash
git clone https://github.com/YOUR_USER/forge.git ~/.forge
ln -sf ~/.forge/dot_config/ghostty ~/.config/ghostty
ln -sf ~/.forge/dot_config/tmux ~/.config/tmux
ln -sf ~/.forge/dot_config/starship.toml ~/.config/starship.toml
ln -sf ~/.forge/dot_config/fastfetch ~/.config/fastfetch
# Source zshrc modules from your .zshrc (see below)
```

## Layout

```
forge/
├── README.md
├── .chezmoiignore
├── dot_config/
│   ├── ghostty/
│   │   ├── config              # Main ghostty config
│   │   └── shaders/
│   │       ├── aurora.glsl     # Subtle aurora background shader
│   │       └── cursor-glow.glsl # Soft cursor trail effect
│   ├── tmux/
│   │   └── tmux.conf           # tmux config with catppuccin + agent workflow
│   ├── starship.toml           # Starship prompt config
│   └── fastfetch/
│       └── config.jsonc        # fastfetch system info display
├── dot_zshrc.d/
│   ├── 00-zinit.zsh            # Plugin manager bootstrap
│   ├── 10-plugins.zsh          # Shell plugins (autosuggestions, syntax, fzf-tab)
│   ├── 20-aliases.zsh          # Aliases for agents, git, k8s
│   ├── 30-agents.zsh           # Agent-specific env and helpers
│   └── 40-prompt.zsh           # Starship init + shell integrations
├── bin/
│   └── worksesh                # Script: create/attach tmux session for a project
└── scripts/
    └── install.sh              # Bootstrap script
```

## The tmux workflow

Each project gets its own tmux session. `worksesh` handles creation:

```bash
# cd into a project, then:
worksesh

# Or specify a path:
worksesh ~/code/vesta
```

This creates a named tmux session (derived from the directory name) with a standard layout:
- Window 0: editor / main terminal
- Window 1: agent (claude/amp/codex — configurable)
- Window 2: server / runner

Switch between projects with `prefix + s` (session picker).

## Agent workflow

The `30-agents.zsh` module sets up aliases and environment for all three agents:

```bash
cc        # → claude (Claude Code)
amp       # → amp (Sourcegraph Amp)
cx        # → codex (OpenAI Codex CLI)
```

Each agent reads its own AGENT.md / CLAUDE.md / AGENTS.md from the project root. The starship prompt shows which agent is active in the current shell.

## Ghostty shaders

Two shaders ship by default, both designed to be subtle enough for daily use:

- **aurora.glsl** — Soft, slow-moving color wash behind the terminal text. Inspired by northern lights. Uses warm Catppuccin palette colors.
- **cursor-glow.glsl** — Gentle glow around the cursor position. Fades over ~200ms.

Toggle shaders off by commenting out the `custom-shader` lines in `~/.config/ghostty/config`. Ghostty hot-reloads shader changes.

## Customization

Everything is meant to be forked and tweaked. The zshrc is modular — add a `50-myproject.zsh` file to `dot_zshrc.d/` and it gets sourced automatically. The tmux config uses sensible defaults with `prefix = Ctrl+Space`.
