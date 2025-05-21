local opt = vim.opt
local g = vim.g

-- Disable netrw (we'll use nvim-tree instead)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Set space as leader key
g.mapleader = ' '
g.maplocalleader = ' '

-- General options
opt.number = true          -- Show absolute line numbers
opt.relativenumber = true  -- Show relative line numbers
opt.mouse = 'a'           -- Enable mouse in all modes
opt.showmode = false       -- Don't show mode since we have a statusline
opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.breakindent = true     -- Maintain indentation on wrapped lines
opt.undofile = true       -- Persistent undo
opt.ignorecase = true     -- Case insensitive searching
opt.smartcase = true      -- Case sensitive if uppercase present
opt.signcolumn = 'yes'    -- Always show sign column
opt.updatetime = 250      -- Faster completion
opt.timeoutlen = 300      -- Time to wait for mapped sequence
opt.splitright = true     -- Vertical splits to the right
opt.splitbelow = true     -- Horizontal splits below
opt.list = true           -- Show some invisible characters
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'  -- Show substitution effects incrementally
opt.cursorline = true     -- Highlight current line
opt.scrolloff = 10        -- Minimum lines to keep above/below cursor
opt.hlsearch = true       -- Highlight search matches
opt.termguicolors = true  -- Enable 24-bit RGB colors

-- Tab/indentation
opt.tabstop = 4           -- Number of spaces a tab counts for
opt.shiftwidth = 4        -- Size of an indent
opt.expandtab = true      -- Use spaces instead of tabs
opt.autoindent = true     -- Autoindent new lines
opt.smartindent = true    -- Smart autoindenting

-- Remove ~ on empty lines and show numbers instead
opt.fillchars:append({
  eob = ' ',              -- Empty end-of-buffer characters
})

-- Persistent line numbers (no ~ on empty lines)
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.relativenumber = true
    vim.opt.number = true
  end,
})

-- Markdown specific
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    opt_local = vim.opt_local
    opt_local.wrap = true
    opt_local.linebreak = true
    opt_local.spell = true
    opt_local.conceallevel = 2 -- for LaTeX concealment
  end
})

-- Disable some builtin plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
