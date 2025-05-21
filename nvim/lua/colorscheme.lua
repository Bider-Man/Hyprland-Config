local M = {}

M.setup = function()
  -- This file is now minimal since we're using a plugin-managed colorscheme
  -- You can add any custom highlights here if needed
  
  -- Example custom highlight (optional):
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#7aa2f7' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ff9e64', bold = true })
  
  -- Ensure terminal colors are set properly
  vim.cmd('set termguicolors')
end

return M
