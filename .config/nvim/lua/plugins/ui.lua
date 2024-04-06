return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = false,
      -- transparent_background = vim.fn.has("gui_running") ~= 1,
      integrations = {
        treesitter = true,
        gitsigns = true,
        notify = true,
        noice = true,
        lsp_trouble = false,
        telescope = {
          enabled = true,
        },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
