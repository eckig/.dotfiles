local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  -- utils
  add('nvim-lua/plenary.nvim')
  add('mini.nvim')

  -- treesitter
  add('nvim-treesitter/nvim-treesitter')
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

  -- git status
  add('lewis6991/gitsigns.nvim')
  require('gitsigns').setup({
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
  })

  -- search/replace
  add('nvim-pack/nvim-spectre')
  vim.keymap.set("n", "<leader>sr", function() require("spectre").open() end )

  -- directory listing
  add('stevearc/oil.nvim')
  require("oil").setup({
    view_options = {
      show_hidden = true
    }
  })

  -- sudo
  add('lambdalisue/suda.vim')
  vim.g.suda_smart_edit = 1
end)
