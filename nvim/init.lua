--Load all the *.lua files
require("options")
require("keymaps")
require("plugins")
require("colorscheme")
require("lsp")
vim.env.PATH = vim.fn.expand("$HOME/.cargo/bin") .. ":" .. vim.env.PATH
