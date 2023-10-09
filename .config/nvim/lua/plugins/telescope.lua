return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Find git file",
      },
      {
        "<leader>fr",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Find previous file",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Find grep",
      },
    },
    dependencies = {
      "nvim-telescope/telescope-fzy-native.nvim",
    },
    config = function()
      local new_maker = function(filepath, bufnr, opts)
        opts = opts or {}
        -- ignore files bigger than a threshold
        filepath = vim.fn.expand(filepath)
        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat then
            return
          end
          if stat.size > 200000 then
            return
          else
            require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
          end
        end)
      end
      require("telescope").load_extension("fzy_native")
      require("telescope").setup({
        defaults = {
          file_sorter = require("telescope.sorters").get_fzy_sorter,
          color_devicons = true,
          buffer_previewer_maker = new_maker,
          file_ignore_patterns = {
            "%.jpeg",
            "%.jpg",
            "%.doc",
            "%.pdf",
            "%.class",
            "%.docx",
            "%.jar",
            "%.zip",
            "%.exe",
            "%.apk",
            "%.pptx",
            "%.ppt",
            "%.png",
            "%.ico",
            "%.xls",
            "%.xlsx",
            "%.vsdx",
            "%.jks",
            "%.vds",
          },
        },
      })
    end,
  },
}
