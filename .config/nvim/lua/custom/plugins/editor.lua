return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'c', 'lua', 'javascript', 'vimdoc', 'vim', 'bash', 'java', 'regex', 'markdown',
          'markdown_inline', 'json', 'css', 'html', 'yaml',
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
      }
    end,
  },

  -- highlight text that changed
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },
}
