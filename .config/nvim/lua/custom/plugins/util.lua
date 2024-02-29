local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add('catppuccin/nvim')
  require("catppuccin").setup({
    transparent_background = vim.fn.has('gui_running') ~= 1,
    integrations = {
      treesitter = true,
      gitsigns = true,
      mini = {
        enabled = true,
      },
    },
  })
  vim.cmd.colorscheme "catppuccin-mocha"

  add('nvim-tree/nvim-web-devicons')
end)

later(function()
  -- utils
  add('nvim-lua/plenary.nvim')

  -- treesitter
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    depends = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    },
  })
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'c', 'lua', 'vimdoc', 'vim', 'bash', 'java', 'regex', 'markdown',
      'markdown_inline', 'json', 'css', 'html', 'yaml', 'xml'
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    },
  }

  -- status column
  add('luukvbaal/statuscol.nvim')
  local sc_builtin = require('statuscol.builtin')
  require('statuscol').setup {
    relculright = true,
    foldfunc = "builtin",
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
          fillchar = ' ',
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
  local git_sign_icon = '▎'
  add('lewis6991/gitsigns.nvim')
  require('gitsigns').setup({
    signs = {
      add = { text = git_sign_icon },
      change = { text = git_sign_icon },
      delete = { text = git_sign_icon },
      topdelete = { text = git_sign_icon },
      changedelete = { text = git_sign_icon },
      untracked = { text = git_sign_icon },
    },
  })

  -- search/replace
  add('nvim-pack/nvim-spectre')
  vim.keymap.set("n", "<leader>sr", function() require("spectre").open() end )
end)
