return {
  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- auto mkdir
  { "jghauser/mkdir.nvim", lazy = true },

  -- Sudo
  { 'lambdalisue/suda.vim', config = function()
      vim.g.suda_smart_edit = 1
    end,
  },
}
