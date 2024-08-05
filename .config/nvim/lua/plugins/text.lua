return {
  {
    "echasnovski/mini.align",
    event = "BufEnter *.properties",
    config = function()
      local align = require("mini.align")
      align.setup({
        options = {
          split_pattern = "=",
          justify_side = "left",
          merge_delimiter = " ",
        },
        steps = {
          pre_justify = { align.gen_step.trim() },
        },
      })
    end,
  },

  {
    "echasnovski/mini.trailspace",
    event = "VeryLazy",
    config = function()
      require("mini.trailspace").setup()
    end,
  },
}
