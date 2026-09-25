-- Leader key: set before anything else so mappings pick it up
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Hybrid line numbers: absolute on the current line, relative on all others
opt.number = true
opt.relativenumber = true

-- Show invisible characters: spaces, tabs, end-of-line, etc.
opt.list = true
opt.listchars = {
	tab = "▸ ",
	space = "·",
	trail = "·",
	nbsp = "␣",
	eol = "↵",
	extends = "⟩",
	precedes = "⟨",
}

-- Sensible basics
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.termguicolors = true
opt.signcolumn = "yes"

-- Persistent undo: history survives restarts, stored outside project dirs
local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p")
opt.undodir = undodir
opt.undofile = true

require("keymaps").setup()
require("theme").setup()
require("updates").setup()

require("plugins.treesitter").setup()
require("plugins.blink").setup()
require("local-tools").setup()
require("lsp").setup()
require("plugins.telescope").setup()
require("plugins.conform").setup()
require("plugins.lualine").setup()
require("plugins.indent").setup()
require("plugins.pairs").setup()
