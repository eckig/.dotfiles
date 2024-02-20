local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local git_sign_icon = '▎'

now(function()
  add('catppuccin/nvim')
  require("catppuccin").setup({
    transparent_background = vim.fn.has('gui_running') ~= 1,
    integrations = {
      treesitter = true,
      gitsigns = true,
      treesitter_context = true,
      mini = {
        enabled = true,
      },
    },
  })
  vim.cmd.colorscheme "catppuccin-mocha"

  add('nvim-tree/nvim-web-devicons')
end)

later(function()
  -- autocomplete
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

  -- utils
  add('nvim-lua/plenary.nvim')

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
          fillchar = git_sign_icon,
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
