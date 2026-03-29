# dotfiles

Personal terminal environment for agentic coding. Ghostty + tmux + Neovim + zsh, managed with [chezmoi](https://www.chezmoi.io/).

---

## Quick Reference (Cheat Sheet)

### Shell

| Shortcut | Action |
|---|---|
| `Ctrl+R` | Atuin fuzzy history search |
| `Ctrl+T` | fzf file finder (insert path) |
| `Alt+C` | fzf directory picker (cd into it) |
| `Up` / `Down` | History substring search (type prefix first) |
| `Tab` | fzf-tab completion (fuzzy menu for any completion) |
| `z <dir>` | Zoxide smart cd (frecency-based) |
| `zi` | Zoxide interactive directory picker |
| `..` / `...` | Go up one / two directories |
| `reload` | Re-source `~/.zshrc` |

### File Listing (eza)

| Alias | Command |
|---|---|
| `ls` | `eza` |
| `ll` | `eza -lah --git` (long list with git status) |
| `la` | `eza -la --git` |
| `lt` | `eza --tree --level=2` |
| `cat` | `bat --style=plain` (syntax-highlighted) |
| `tree` | `tree` (excludes node_modules, .git, build, dist) |

### Git

| Alias | Command |
|---|---|
| `g` | `git` |
| `gs` | `git status -sb` |
| `gd` | `git diff` |
| `gds` | `git diff --staged` |
| `gc` | `git commit` |
| `gca` | `git commit --amend --no-edit` |
| `gco` | `git checkout` |
| `gb` | `git branch --sort=-committerdate` |
| `gl` | `git log --oneline -20` |
| `gp` | `git push` |
| `gpf` | `git push --force-with-lease` |
| `gwt` | `git worktree` |
| `gwtl` | `git worktree list` |

### Docker

| Alias | Command |
|---|---|
| `d` | `docker` |
| `dc` | `docker compose` |
| `dps` | `docker ps` (table: name, status, ports) |

### tmux (prefix: `Ctrl+Space`)

| Keys | Action |
|---|---|
| `prefix c` | New window (inherits cwd) |
| `prefix 1/2/3` | Switch to window by number |
| `prefix \|` | Split pane horizontally |
| `prefix -` | Split pane vertically |
| `prefix s` | Session picker (tree view) |
| `prefix S` | Create new named session |
| `prefix X` | Kill current session (with confirm) |
| `prefix C-c` | Open Claude Code in new window |
| `prefix C-a` | Open Amp in new window |
| `prefix C-x` | Open Codex in new window |
| `prefix r` | Reload tmux config |
| `prefix h/j/k/l` | Navigate panes (fallback) |
| `prefix H/J/K/L` | Resize pane by 5 cells |
| `Ctrl+h/j/k/l` | Navigate panes (seamless with Neovim) |

| Alias | Command |
|---|---|
| `t` | `tmux` |
| `ta` | `tmux attach -t` |
| `tl` | `tmux list-sessions` |
| `tk` | `tmux kill-session -t` |

### Agent Tools

| Alias | Command |
|---|---|
| `cc` | `claude` (Claude Code) |
| `cch` | `claude --print` (headless / one-shot) |
| `aa` | `amp` |
| `cx` | `codex` (OpenAI Codex CLI) |
| `cs` | `claude-squad` (multi-agent TUI) |

### Ghostty

| Keys | Action |
|---|---|
| `Super+N` | New window |
| `Super+T` | New tab |
| `Super+Shift+Enter` | Auto-split (horizontal or vertical) |
| `Super+Ctrl+Arrow` | Navigate between Ghostty splits |
| `Super+Shift+S` | Reload config (toggle shaders on/off) |

### Neovim

| Keys | Action |
|---|---|
| `jk` | Exit insert mode |
| `<leader>w` | Save file |
| `Esc` | Clear search highlight |
| `Shift+H` / `Shift+L` | Previous / next buffer |
| `Ctrl+D` / `Ctrl+U` | Scroll down / up (centered) |
| `n` / `N` | Next / prev search result (centered) |
| `J` / `K` (visual) | Move selected lines down / up |
| `<leader>gd` | Diffview: open working tree diff |
| `<leader>gh` | Diffview: file history (current file) |
| `<leader>gH` | Diffview: file history (whole repo) |
| `<leader>gq` | Diffview: close |
| `<leader>ac` | Toggle Claude Code panel |
| `<leader>af` | Focus Claude Code panel |
| `<leader>ar` | Resume Claude session |
| `<leader>aC` | Continue Claude session |
| `<leader>am` | Select Claude model |
| `<leader>ab` | Add current buffer to Claude context |
| `<leader>as` (visual) | Send selection to Claude |
| `<leader>aa` | Accept diff from Claude |
| `<leader>ad` | Deny diff from Claude |
| `Ctrl+h/j/k/l` | Navigate between tmux panes and Neovim splits |

---

## What's in here

- **Ghostty** -- GPU-accelerated terminal with GLSL shaders, Catppuccin Mocha theme, Maple Mono NF font
- **tmux** -- session-per-project workflow, vi copy mode, Catppuccin status bar, vim-tmux-navigator, auto-save via continuum
- **Neovim** -- LazyVim with claudecode.nvim, diffview.nvim, vim-tmux-navigator, Catppuccin Mocha
- **zsh** -- modular config (`~/.zshrc.d/*.zsh`), sheldon plugin manager, starship prompt, atuin history, zoxide, fzf
- **Git** -- delta for syntax-highlighted side-by-side diffs, histogram diff algorithm, rerere, worktree symlink hook
- **mise** -- unified runtime management (Node LTS, Python 3.13)
- **Brewfile** -- declarative package manifest for all CLI tools
- **claude-squad** -- multi-agent orchestration across git worktrees

## Quick start

```bash
brew install chezmoi
chezmoi init --apply https://github.com/kencrim/dotfiles.git
```

That single command installs all packages (via Brewfile), deploys all configs, and wires up `~/.zshrc`. After it completes:

1. Open a new terminal (or `exec zsh`)
2. Run `tmux` -- then press `Ctrl+Space I` to install tmux plugins
3. Run `nvim` to bootstrap LazyVim on first launch

---

## Shell Shortcuts

### History and Search

| Shortcut | Tool | What it does |
|---|---|---|
| `Ctrl+R` | Atuin | Full-screen fuzzy search across shell history (synced, context-aware) |
| `Up` / `Down` | zsh-history-substring-search | Search history by prefix (type a few chars, then arrow) |
| `Ctrl+T` | fzf | Find a file and insert its path at the cursor |
| `Alt+C` | fzf | Find a directory and cd into it |
| `Tab` | fzf-tab | Fuzzy completion menu for commands, paths, arguments |

Atuin has `--disable-up-arrow` set, so the Up arrow is reserved for substring search, not atuin.

### Autosuggestions

As you type, `zsh-autosuggestions` shows a dimmed suggestion from history. Press the right arrow to accept it.

Strategy order: history, then completion.

### Navigation

| Command | What it does |
|---|---|
| `z <partial>` | Jump to a frequently/recently visited directory (zoxide) |
| `zi` | Interactive zoxide directory picker |
| `..` | `cd ..` |
| `...` | `cd ../..` |

---

## Git Aliases

All git aliases are defined in `dot_zshrc.d/20-aliases.zsh`.

| Alias | Expands to | Purpose |
|---|---|---|
| `g` | `git` | Shorthand |
| `gs` | `git status -sb` | Short status with branch info |
| `gd` | `git diff` | Unstaged changes |
| `gds` | `git diff --staged` | Staged changes |
| `gc` | `git commit` | Commit |
| `gca` | `git commit --amend --no-edit` | Amend last commit (keep message) |
| `gco` | `git checkout` | Checkout branch or file |
| `gb` | `git branch --sort=-committerdate` | List branches by recency |
| `gl` | `git log --oneline -20` | Last 20 commits, compact |
| `gp` | `git push` | Push |
| `gpf` | `git push --force-with-lease` | Force push (safe) |
| `gwt` | `git worktree` | Worktree management |
| `gwtl` | `git worktree list` | List worktrees |

### Git Config Highlights

Configured in `dot_config/git/config.tmpl`:

- **Pager**: `delta` with side-by-side diffs, line numbers, Catppuccin Mocha syntax theme
- **Diff**: histogram algorithm, colorMoved enabled
- **Merge**: zdiff3 conflict style
- **Push**: `autoSetupRemote = true` (no manual `--set-upstream`)
- **Pull**: rebase by default
- **rerere**: enabled (remembers conflict resolutions)
- **Editor**: nvim
- **Global gitignore**: `.DS_Store`, `.idea/`, `.vscode/`, `*.swp`, `.env`, `.env.local`

### Worktree Symlink Hook

A global `post-checkout` hook (at `~/.config/git/hooks/`) automatically symlinks shared files when you create a new git worktree:

- `.env*` files from the main worktree
- `node_modules`, `.venv`, `vendor`, `Pods`, `.gradle` (ecosystem-dependent)
- `.next`, `.nuxt` build caches
- pnpm monorepo workspace `node_modules`

This means `git worktree add` gives you a ready-to-use working copy without reinstalling dependencies.

---

## Docker Aliases

| Alias | Expands to | Purpose |
|---|---|---|
| `d` | `docker` | Shorthand |
| `dc` | `docker compose` | Compose shorthand |
| `dps` | `docker ps --format 'table ...'` | Clean table: name, status, ports |

---

## tmux

### Prefix

The prefix key is `Ctrl+Space` (not the default `Ctrl+B`).

### Window and Pane Management

| Keys | Action |
|---|---|
| `prefix c` | New window (inherits current directory) |
| `prefix 1` / `2` / `3` | Switch to window by number |
| `prefix \|` | Split pane horizontally |
| `prefix -` | Split pane vertically |
| `prefix h/j/k/l` | Navigate panes (prefix-based fallback) |
| `prefix H/J/K/L` | Resize pane by 5 cells (repeatable) |
| `Ctrl+h/j/k/l` | Navigate panes (no prefix needed, works across Neovim splits) |

### Sessions

| Keys | Action |
|---|---|
| `prefix s` | Session picker (tree view) |
| `prefix S` | Create a new named session |
| `prefix X` | Kill current session (with confirmation) |

### Agent Windows

| Keys | Action |
|---|---|
| `prefix C-c` | Launch Claude Code in a new window |
| `prefix C-a` | Launch Amp in a new window |
| `prefix C-x` | Launch Codex in a new window |

### Vi Copy Mode

| Keys | Action |
|---|---|
| `prefix [` | Enter copy mode |
| `v` | Begin selection |
| `y` | Yank selection to system clipboard (pbcopy) |
| `Escape` | Cancel copy mode |

### Shell Aliases

| Alias | Command |
|---|---|
| `t` | `tmux` |
| `ta` | `tmux attach -t` |
| `tl` | `tmux list-sessions` |
| `tk` | `tmux kill-session -t` |

### Configuration Details

- Windows and panes are 1-indexed (`base-index 1`, `pane-base-index 1`)
- Mouse support enabled
- Scrollback: 50,000 lines
- Extended keys enabled (fixes Shift+Enter, Ctrl+Enter in agent TUIs)
- Auto-renumber windows on close
- True color and focus events enabled
- Status bar at top, Catppuccin Mocha palette

### Plugins (via TPM)

| Plugin | Purpose |
|---|---|
| tmux-resurrect | Save/restore sessions across restarts |
| tmux-continuum | Auto-save sessions every 10 minutes |
| tmux-sessionist | Enhanced session management |

Install plugins on first run: `prefix I`

---

## Ghostty Keybindings

Ghostty is the terminal emulator. Keybindings are set to avoid conflicting with `Ctrl+Space` (tmux prefix).

| Keys | Action |
|---|---|
| `Super+N` | New Ghostty window |
| `Super+T` | New Ghostty tab |
| `Super+Shift+Enter` | New split (auto-direction) |
| `Super+Ctrl+Left` | Navigate to left split |
| `Super+Ctrl+Right` | Navigate to right split |
| `Super+Ctrl+Up` | Navigate to top split |
| `Super+Ctrl+Down` | Navigate to bottom split |
| `Super+Shift+S` | Reload config (use to toggle shaders) |

### Terminal Settings

- Font: Maple Mono NF, size 14, thickened
- Theme: Catppuccin Mocha
- Background opacity: 0.92 with blur
- Cursor: blinking bar
- Shell integration: zsh (cursor, sudo, title features)
- Scrollback: 50,000 lines
- Unfocused split opacity: 0.85
- Link detection enabled, mouse hides while typing

---

## Agent Tools

### Aliases

| Alias | Command | Description |
|---|---|---|
| `cc` | `claude` | Claude Code (interactive) |
| `cch` | `claude --print` | Claude Code headless (one-shot, stdout) |
| `aa` | `amp` | Amp |
| `cx` | `codex` | OpenAI Codex CLI |
| `cs` | `claude-squad` | Multi-agent TUI (worktree-based) |

### Wrapper Functions

Each agent (`claude`, `amp`, `codex`) has a shell wrapper that sets `DOTFILES_ACTIVE_AGENT` while the agent runs. This variable is picked up by the starship prompt so you can see which agent is active in the current shell.

### claude-squad

`claude-squad` manages multiple Claude Code instances in isolated git worktrees -- one worktree per task, automatic branch creation. Run `cs` to open the TUI.

---

## Neovim

LazyVim-based config with keybindings optimized for reviewing AI-generated code.

### General Keymaps

| Keys | Mode | Action |
|---|---|---|
| `jk` | Insert | Exit insert mode |
| `<leader>w` | Normal | Save file |
| `Esc` | Normal | Clear search highlight |
| `Shift+H` | Normal | Previous buffer |
| `Shift+L` | Normal | Next buffer |
| `Ctrl+D` | Normal | Scroll down (centered) |
| `Ctrl+U` | Normal | Scroll up (centered) |
| `n` / `N` | Normal | Next / prev search result (centered) |
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |

### Claude Code Integration (claudecode.nvim)

| Keys | Mode | Action |
|---|---|---|
| `<leader>ac` | Normal | Toggle Claude Code panel |
| `<leader>af` | Normal | Focus Claude Code panel |
| `<leader>ar` | Normal | Resume Claude session |
| `<leader>aC` | Normal | Continue Claude session |
| `<leader>am` | Normal | Select Claude model |
| `<leader>ab` | Normal | Add current buffer to Claude context |
| `<leader>as` | Visual | Send selection to Claude |
| `<leader>as` | Normal (file tree) | Add file to Claude context |
| `<leader>aa` | Normal | Accept diff from Claude |
| `<leader>ad` | Normal | Deny diff from Claude |

The Claude panel opens on the right side (40% width) via snacks.nvim terminal provider.

### Diffview (code review)

| Keys | Action |
|---|---|
| `<leader>gd` | Open diff view (working tree) |
| `<leader>gh` | File history for current file |
| `<leader>gH` | File history for entire repo |
| `<leader>gq` | Close diff view |

### Navigation

| Keys | Action |
|---|---|
| `Ctrl+h/j/k/l` | Navigate between tmux panes and Neovim splits seamlessly |

Files auto-reload when agents modify them on disk. Swap files are disabled to avoid conflicts.

---

## Shaders

Ghostty supports stackable GLSL shaders. Three are configured (applied in order):

| Shader | Description |
|---|---|
| `aurora.glsl` | Slow-moving color wash behind terminal text, using Catppuccin palette colors |
| `workstream.glsl` | Workstream shader (referenced in config) |
| `cursor-glow.glsl` | Subtle glow effect around the cursor position |

Shaders animate continuously (`custom-shader-animation = always`).

To toggle shaders off: comment out the `custom-shader` lines in `~/.config/ghostty/config` and press `Super+Shift+S` to reload, or just edit and save (Ghostty hot-reloads).

---

## Tools and Runtimes

### Runtime Management (mise)

[mise](https://mise.jdx.dev/) manages language runtimes. Configured versions:

| Runtime | Version |
|---|---|
| Node.js | LTS |
| Python | 3.13 |

Activated automatically in every shell via `mise activate zsh`.

### PATH

The following directories are on PATH (in priority order):

1. `~/bin` -- chezmoi-deployed scripts
2. `~/.local/bin` -- Claude Code, uv, pipx, etc.
3. `$PNPM_HOME` (`~/Library/pnpm`)
4. Homebrew (`/opt/homebrew/bin`)
5. Go (`~/go/bin`)
6. Maestro (`~/.maestro/bin`)

### Zsh Plugins (sheldon)

| Plugin | Purpose |
|---|---|
| zsh-defer | Deferred loading for faster shell startup |
| zsh-completions | Additional completion definitions |
| zsh-autosuggestions | Inline history/completion suggestions (deferred) |
| zsh-syntax-highlighting | Command syntax coloring (deferred) |
| zsh-history-substring-search | Up/Down arrow searches history by typed prefix |
| fzf-tab | Replace default completion menu with fzf |

### Installed CLI Tools (Brewfile)

| Tool | Purpose |
|---|---|
| ghostty | GPU-accelerated terminal emulator |
| sheldon | Zsh plugin manager |
| starship | Cross-shell prompt |
| atuin | Synced shell history with fuzzy search |
| zoxide | Smarter `cd` (frecency-based) |
| fzf | General-purpose fuzzy finder |
| neovim | Editor |
| bat | `cat` with syntax highlighting |
| eza | Modern `ls` replacement |
| fd | Fast `find` alternative |
| ripgrep | Fast `grep` alternative |
| delta | Git diff viewer with syntax highlighting |
| jq | JSON processor |
| lazygit | Terminal UI for git |
| yazi | Terminal file manager |
| btop | System resource monitor |
| tree | Directory tree listing |
| fastfetch | System info display (shown on shell start) |
| mise | Runtime version manager |
| tmux | Terminal multiplexer |
| claude-squad | Multi-agent orchestration |
| go-task | Task runner (Taskfile) |
| goreleaser | Go release automation |
| font-maple-mono-nf | Nerd Font (Maple Mono) |

### Starship Prompt

Two-line prompt showing:

- Line 1: directory, git branch, git status, active agent name (if any), command duration (if > 2s)
- Line 2: prompt character (`>` in lavender, red on error)

Disabled modules: package, nodejs, python, rust, java (kept clean, mise handles runtimes).

---

## Layout

```
dotfiles/
├── .chezmoi.toml.tmpl              # chezmoi config (prompts for git identity)
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
│   │   ├── config.tmpl             # Git config with delta (templated)
│   │   ├── ignore                  # Global gitignore
│   │   └── hooks/
│   │       └── post-checkout       # Worktree symlink automation
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
```

## Customization

Zsh config is modular -- drop a `50-myproject.zsh` file into `dot_zshrc.d/` and it auto-sources. Neovim plugins go in `dot_config/nvim/lua/plugins/`. Everything is meant to be forked and tweaked.
