return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    config = function()
      require("telescope").setup({
        defaults = {
          path_display = {
            filename_first = {
              reverse_directories = false
            }
          },
        },
      })
    end,
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = vim.fn.executable("make") == 1 and "make"
          or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    keys = {
      { "<leader>/", function() require('telescope.builtin').live_grep() end, desc = "Grep (Root Dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- find
      { "<leader>ff", function() require('telescope.builtin').find_files() end, desc = "Find Files (Root Dir)" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      -- search
      { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>fw", function() require('telescope.builtin').grep_string() end, desc = "Word (Root Dir)" },
      { "<leader>fw", function() require('telescope.builtin').grep_string() end, mode = "v", desc = "Selection (Root Dir)" },
    },
  },
}
