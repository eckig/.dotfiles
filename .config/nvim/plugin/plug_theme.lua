local add = vim.pack.add
local now = Config.now

now(function()

  add( {'https://github.com/f-person/auto-dark-mode.nvim'} )
  require('auto-dark-mode').setup()

  add( {'https://github.com/miikanissi/modus-themes.nvim'} )
  vim.cmd([[colorscheme modus]])
end)
