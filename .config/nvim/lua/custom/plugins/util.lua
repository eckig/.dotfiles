return {
  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- auto mkdir
  { "jghauser/mkdir.nvim", lazy = true },

  -- search/replace
  { "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

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
