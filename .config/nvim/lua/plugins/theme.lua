return {
  "ronisbr/nano-theme.nvim",
  lazy = false,

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nano-theme",
    },
    init = function()
      vim.o.background = "light"
    end,
  },
}
