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
      'markdown_inline', 'json', 'css', 'html', 'yaml', 'xml'
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    },
  }
  add('JoosepAlviste/nvim-ts-context-commentstring')


  -- status column
  add('luukvbaal/statuscol.nvim')
  local sc_builtin = require('statuscol.builtin')
  require('statuscol').setup {
    relculright = true,
    segments = {
      {
        sign = {
          name = { ".*" },
          namespace = { ".*" },
          maxwidth = 1,
          colwidth = 2,
          auto = false,
          wrap = true,
        },
      },
      {
        text = { sc_builtin.lnumfunc, " " },
        colwidth = 1,
      },
      {
        sign = {
          name = { "GitSigns*" },
          namespace = { "gitsigns" },
          colwidth = 1,
          fillchar = '▎',
          fillcharhl = "Nrline"
        },
      },
      {
        text = { sc_builtin.foldfunc, " " },
        hl = "FoldColumn",
        wrap = true,
        colwidth = 1,
      },
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

  -- sudo
  add('lambdalisue/suda.vim')
  vim.g.suda_smart_edit = 1
end)
