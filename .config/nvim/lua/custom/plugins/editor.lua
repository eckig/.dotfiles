return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },

  -- Fuzzy finder.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
      },
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").git_files()
        end,
      },
      {
        "<leader>fr",
        function()
          require("telescope.builtin").oldfiles()
        end,
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          mappings = {
            n = {
              ["q"] = actions.close,
            },
          },
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
