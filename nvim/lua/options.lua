--------------------------------------------
-------- GENERAL OPTIONS FOR NEOVIM --------
--------------------------------------------

-------- GLOBAL VARIABLES --------

local g = vim.g -- Global Variables
local opt = vim.opt -- Set the options
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.mkdp_mathjax = 1 --Enables LaTeX Rendering

--------- GENERAL ---------

opt.mouse = "a" -- Enable Mouse Support
opt.clipboard = "unnamedplus" -- Use System Clipboard
opt.swapfile = true -- Use Swapfile

-------- NEOVIM UI --------

opt.number = true -- Show Line Number
opt.relativenumber = true -- Show Relative Line Number
opt.foldmethod = "marker" -- Enable Folding
opt.colorcolumn = "80" -- Length of the Line is 80 Columns
opt.splitright = true -- Vertical Split to the Right
opt.splitbelow = true -- Horizontal Split to the Bottom
opt.ignorecase = true -- Ignore Case Sensitivity During Search
opt.smartcase = true -- Ignore Lower Case for the Whole Pattern
opt.linebreak = true -- Wrap Around on the Boundary
opt.termguicolors = true -- Enable 24-bit RGB Colors
opt.laststatus = 3 -- Set Global Status Line

-------- TABS & INDENTS --------

opt.expandtab = false -- Use Spaces Instead of Tabs
opt.shiftwidth = 4 -- Shift Four Spaces When Tabbing
opt.tabstop = 4 -- One Tab = Four Spaces
opt.smartindent = true -- Autoindent New Lines

-------- MEMORY & CPU --------

opt.hidden = true -- Enable Background Buffers
opt.history = 100 -- Remember X Lines in History
opt.lazyredraw = true -- Faster Scrolling
opt.synmaxcol = 240 -- Max Columns for Syntax Highlight
opt.updatetime = 250 -- Update Time in ms for Event Trigger

-------- DISABLE BUILT-IN PLUGINS --------

local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getsscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

