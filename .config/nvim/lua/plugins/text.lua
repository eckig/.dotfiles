return {
  {
    'echasnovski/mini.cursorword',
    event = "VeryLazy",
    init = function()
      require('mini.cursorword').setup()
    end
  },

  {
    'echasnovski/mini.move',
    event = "VeryLazy",
    init = function()
      require('mini.move').setup({
        mappings = {
          left  = '',
          right = '',
          down  = 'J',
          up    = 'K',
        }
      })
    end,
  },

  {
    'echasnovski/mini.hipatterns',
    event = "VeryLazy",
    init = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
          todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
          note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },

}
