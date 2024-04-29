return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "dayfox"
    end,
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
