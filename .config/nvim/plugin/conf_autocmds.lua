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
_Z.new_autocmd('FileType', nil, f, "Proper 'formatoptions'")

-- open last edit location
-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
-- see https://github.com/neovim/neovim/issues/16339
local ignore_buftype = { "quickfix", "nofile", "help" }
local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }

local function run()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    -- reset cursor to first line
    vim.cmd[[normal! gg]]
    return
  end

  -- If a line has already been specified on the command line, we are done
  --   nvim file +num
  if vim.fn.line(".") > 1 then
    return
  end

  local last_line = vim.fn.line([['"]])
  local buff_last_line = vim.fn.line("$")

  -- If the last line is set and the less than the last line in the buffer
  if last_line > 0 and last_line <= buff_last_line then
    local win_last_line = vim.fn.line("w$")
    local win_first_line = vim.fn.line("w0")
    -- Check if the last line of the buffer is the same as the win
    if win_last_line == buff_last_line then
      -- Set line to last line edited
      vim.cmd[[normal! g`"]]
      -- Try to center
    elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
      vim.cmd[[normal! g`"zz]]
    else
      vim.cmd[[normal! G'"<c-e>]]
    end
  end
end

vim.api.nvim_create_autocmd({'BufWinEnter', 'FileType'}, {
  group    = vim.api.nvim_create_augroup('nvim-lastplace', {}),
  callback = run
})
