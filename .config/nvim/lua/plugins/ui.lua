return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = vim.fn.has("gui_running") ~= 1,
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

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        diagnostics = "",
        always_show_bufferline = true,
        show_buffer_close_icons = false,
      },
    },
  },
}
