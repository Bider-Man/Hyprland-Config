--Loading Core Configurations
require("options")
require("keymaps")

--Loading Plugin Manager and Plugins
require("plugins")

--Loading Color Scheme (Tokyo Night)
require("colorscheme")

--Loading Telekasten
require("telekasten").setup({
	home = vim.fn.expand("~/SRH"),
})

--Markdown Preview
vim.g.mkdp_mathjax = 1 --Enables LaTeX Rendering
