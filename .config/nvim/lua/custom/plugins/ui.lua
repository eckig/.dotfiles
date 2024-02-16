local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add('catppuccin/nvim')
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
end)

now(function()
  add('nvim-tree/nvim-web-devicons')
end)

now(function()
  add('nvim-tree/nvim-web-devicons')
end)

later(function()
  add('hrsh7th/nvim-cmp')
  add('hrsh7th/cmp-cmdline')
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
end)
