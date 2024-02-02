return {
  { 'echasnovski/mini.nvim', version = false, config = function()
      require('mini.tabline').setup()

      local notify = require('mini.notify')
      notify.setup()
      vim.notify = notify.make_notify()

      local indentscope = require('mini.indentscope')
      indentscope.setup()
      indentscope.gen_animation.none()

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

      require('mini.statusline').setup()

    end,},
}