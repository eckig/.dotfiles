return {
  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- auto mkdir
  { "jghauser/mkdir.nvim", lazy = true },

  -- search
  { "nvim-pack/nvim-spectre" },

  -- dir view
  { "stevearc/oil.nvim", config = function()
      require("oil").setup()
    end,
  },

  -- Sudo
  { 'lambdalisue/suda.vim', config = function()
      vim.g.suda_smart_edit = 1
    end,
  },
}
