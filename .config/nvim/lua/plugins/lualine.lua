return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    return {
      sections = {
       lualine_y = { "location" },
        -- disable clock
        lualine_z = {},
      },
    }
  end,
}
