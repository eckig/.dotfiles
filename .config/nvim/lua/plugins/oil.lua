return {
  {
    "stevearc/oil.nvim",
    event = "VimEnter",
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      {
        "<leader>fd",
        function()
          require("oil").open_float(vim.fn.expand("%:p:h"))
        end,
      },
    },
  },
}
