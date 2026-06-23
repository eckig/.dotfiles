local add = vim.pack.add
local now = Config.now

now(function()
  add( {'https://github.com/f-person/auto-dark-mode.nvim'} )
  require('auto-dark-mode').setup()
end)
