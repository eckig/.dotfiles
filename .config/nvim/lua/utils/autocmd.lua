_Z = {}
-- Define custom autocommand group and helper to create an autocommand.
local gr = vim.api.nvim_create_augroup('z-config', {})
_Z.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end
