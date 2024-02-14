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
          mini = {
            enabled = true,
          },
        },
      })
      vim.cmd.colorscheme "catppuccin-latte"
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-cmdline", init = function()
      local cmp = require'cmp'
      cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = 'path' } }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' }
          }
        }
      })
    })
    end
  },
}
