-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost",
{
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- reload changed file:
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" },
{
  command = "if mode() != 'c' | checktime | endif",
  pattern = "*",
})

-- replace umlauts in properties
vim.api.nvim_create_autocmd({ "BufWritePre" },
{
  pattern = { "messages*.properties" },
  callback = function(event)
    vim.cmd(":set noignorecase")
    vim.cmd(":%s/ä/\\\\u00E4/ge")
    vim.cmd(":%s/Ä/\\\\u00C4/ge")
    vim.cmd(":%s/Ö/\\\\u00D6/ge")
    vim.cmd(":%s/ö/\\\\u00F6/ge")
    vim.cmd(":%s/ü/\\\\u00FC/ge")
    vim.cmd(":%s/Ü/\\\\u00DC/ge")
    vim.cmd(":%s/ß/\\\\u00DF/ge")
  end,
})

-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
local f = function() vim.cmd('setlocal formatoptions-=c formatoptions-=o') end
_Z.new_autocmd({ 'BufEnter', 'FileType' }, nil, f, "Proper 'formatoptions'")
