return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.o.background = "dark"
    vim.cmd.colorscheme "gruvbox"
  end,
}
