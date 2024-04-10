return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      {
        "<leader>fd",
        function()
          require("oil").open_float(vim.fn.expand('%:p:h'))
        end,
      },
    },
  },
}
