return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            "^%.git/",
            "^%.git$",
            ".DS_Store",
          },
          borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          preview = { hide_on_startup = true },
          layout_strategy = 'vertical',
          layout_config = {
            vertical = {
              mirror = true,
              prompt_position = 'top',
              width = function(_, cols, _)
                return math.min( math.floor( 0.85 * cols ), 80 )
              end,
              height = function(_, _, rows)
                return math.floor( rows * 0.85 )
              end,
              preview_cutoff = 10,
              preview_height = 0.4,
            },
          },

          results_title = '',
          sorting_strategy = 'ascending',
          border = { prompt = { 1, 1, 1, 1 }, results = { 1, 1, 1, 1 }, preview = { 1, 1, 1, 1 }, },
          path_display = { "filename_first" }, -- trunctate or filename_first
          mappings = {
            n = {
              ['o'] = require('telescope.actions.layout').toggle_preview,
            },
            i = {
              ['<C-o>'] = require('telescope.actions.layout').toggle_preview,
            },
          },
          path_display = {
            filename_first = {
              reverse_directories = false
            }
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            additional_args = { "--hidden" }
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
