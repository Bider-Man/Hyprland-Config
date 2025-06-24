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

--Autocomplete
local function setup_completion()
  local cmp = require('cmp')
  cmp.setup({
    mapping = {
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
      -- Optional: You might want to keep other mappings or adjust them
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }
  })
end

-- If you're using nvim-cmp or another completion plugin
if pcall(require, 'cmp') then
  setup_completion()
end
