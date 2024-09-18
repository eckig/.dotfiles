return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return {
        defaults = {
          path_display = {
            filename_first = {
              reverse_directories = false,
            },
          },
        },
      }
    end,
  },
}
