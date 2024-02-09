return {
  { 'echasnovski/mini.nvim',
    version = false,
    lazy = false,
    keys = {
      { "<leader>ff", function() require("mini.pick").builtin.files({ tool = 'git' }) end, },
      { "<leader>fr", function() require("mini.extra").pickers.oldfiles() end, },
      { "<leader>fg", function() require("mini.pick").builtin.grep_live() end, },
    },
    config = function()
      -- tabs
      require('mini.tabline').setup()

      -- picker
      require('mini.pick').setup()

      -- extras
      require('mini.extra').setup()

      ----------------------------------------------------------------------------------------------------------------
      -- notifications
      local notify = require('mini.notify')
      notify.setup()
      vim.notify = notify.make_notify()

      ----------------------------------------------------------------------------------------------------------------
      -- start screen

      local logo = [[
███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]]

      local starter = require('mini.starter')
      starter.setup({
        header = logo,
        items = {
          starter.sections.recent_files(9, false, false),
          { name = 'Plugins',        action = 'lua require("lazy").home()',    section = 'Misc' },
          { name = 'Find & Replace', action = 'lua require("spectre").open()', section = 'Misc' },
        },
      })

      ----------------------------------------------------------------------------------------------------------------
      -- indent guide
      local indentscope = require('mini.indentscope')
      indentscope.setup()
      indentscope.gen_animation.none()

      ----------------------------------------------------------------------------------------------------------------
      -- text highlighting
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

      ----------------------------------------------------------------------------------------------------------------
      -- status line
      local get_filetype_icon = function()
        local file_name, file_ext = vim.fn.expand('%:t'), vim.fn.expand('%:e')
        return require('nvim-web-devicons').get_icon(file_name, file_ext, { default = true })
      end

      local file_icon = { unix = " LF", dos = " CRLF", mac = " CR", }
      local file_format = function()
        local text = vim.bo.fileformat
        if text == '' then
          return ''
        end
        local icon = file_icon[text]
        if icon == '' then
          return text
        end
        return icon
      end

      local min_section_fileinfo = function()
        local filetype = vim.bo.filetype

        if (filetype == '') then return '' end

        local icon = get_filetype_icon()
        if icon ~= '' then filetype = string.format('%s %s', icon, filetype) end

        local encoding = vim.bo.fileencoding or vim.bo.encoding
        local format = file_format()

        return string.format('%s %s %s', filetype, encoding, format)
      end

      local get_root_dir = function()
        local root_patterns = { ".git", "pom.xml", "build.gradle" }
        local cur_dir_buf = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
        local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true, path = cur_dir_buf })[1])
        if root_dir == nil then return vim.fn.getcwd() end
        return root_dir
      end

      require('mini.statusline').setup({
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git           = MiniStatusline.section_git({ trunc_width = 120 })
            local fileinfo      = min_section_fileinfo()
            local location      = '%l|%L'
            local dir           = ' %s' .. vim.fn.fnamemodify(get_root_dir(), ':t')

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                  strings = { mode } },
              { hl = 'MiniStatuslineDevinfo',  strings = { git } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { dir } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl,                  strings = { location } },
            })
          end,
          inactive = nil,
        }
      })

    end,},
}
