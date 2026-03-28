-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- UI
opt.relativenumber = true
opt.number = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Splits open below and right (matches tmux convention)
opt.splitbelow = true
opt.splitright = true

-- File handling — critical for AI agent workflow
opt.autoread = true
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Performance
opt.updatetime = 200
opt.timeoutlen = 300

-- System clipboard
opt.clipboard = "unnamedplus"
