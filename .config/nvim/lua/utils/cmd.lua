vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

local map = vim.keymap.set
map("n", "<leader>cc", "<cmd>Cppath<cr>")
