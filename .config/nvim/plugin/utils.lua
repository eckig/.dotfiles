local cmd = vim.cmd

-- if deleting a blank line, yank into black-hole register
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end

vim.keymap.set( "n", "dd", smart_dd, { noremap = true, expr = true } )

-- Check if we need to reload the file when it changed
cmd("au FocusGained * :checktime")

-- Highlight on yank
cmd("au TextYankPost * lua vim.highlight.on_yank {}")
