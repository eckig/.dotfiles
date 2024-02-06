return {

  { "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    init = function()
      require("catppuccin").setup({
        transparent_background = true,
        integrations = {
          treesitter = true,
          gitsigns = true,
          telescope = {
            enabled = true,
          },
          mini = {
            enabled = true,
          },
        },
      })
      vim.cmd.colorscheme "catppuccin-latte"
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
}
