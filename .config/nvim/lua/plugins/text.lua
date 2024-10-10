return {
  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup()
    end,
  },

  {
    "echasnovski/mini.align",
    event = "BufEnter *.properties",
    config = function()
      local var align = require("mini.align")
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

  {
    "echasnovski/mini.hipatterns",
    event = "VeryLazy",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
}
