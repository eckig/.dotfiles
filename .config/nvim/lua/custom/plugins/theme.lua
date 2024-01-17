return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  init = function()
    require("catppuccin").setup({
      transparent_background = true,
      integrations = {
        notify = true,
        treesitter = true,
        noice = true,
      },
    })
    vim.cmd.colorscheme "catppuccin-latte"
  end,
}
