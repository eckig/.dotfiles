return {
  "ronisbr/nano-theme.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.o.background = "light"
    vim.cmd.colorscheme 'nano-theme'
  end,
}
