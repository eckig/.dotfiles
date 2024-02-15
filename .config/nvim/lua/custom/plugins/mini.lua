return {
  { 'echasnovski/mini.nvim',
    version = false,
    lazy = false,
    keys = {
      { "<leader>ff", function() require("mini.pick").builtin.files({ tool = 'git' }) end, },
      { "<leader>fr", function() require("mini.extra").pickers.oldfiles() end, },
      { "<leader>fg", function() require("mini.pick").builtin.grep_live() end, },
      { "<leader>fb", function() require("mini.pick").builtin.buffers() end, },
    },
    config = function()
      -- tabs
      require('mini.tabline').setup()

      -- picker
      require('mini.pick').setup()

      -- extras
      require('mini.extra').setup()

      -- cursorword
      require('mini.cursorword').setup()

      -- trailspace
      require('mini.trailspace').setup()

      ----------------------------------------------------------------------------------------------------------------
      -- notifications
      local notify = require('mini.notify')
      notify.setup()
      vim.notify = notify.make_notify()

      ----------------------------------------------------------------------------------------------------------------
      -- start screen
      local starter = require('mini.starter')

      local disable_statusline = function(data) vim.b[data.buf].ministatusline_disable = true end
      vim.api.nvim_create_autocmd('User', { pattern = 'MiniStarterOpened', callback = disable_statusline })

      starter.setup({
        header = [[
███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]] ,
        items = {
          starter.sections.recent_files(12, false, false),
          { name = 'Update Plugins',        action = 'lua require("lazy").update()', section = 'Misc' },
          { name = 'Find & Replace', action = 'lua require("spectre").open()',       section = 'Misc' },
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

      local file_format = function()
        local line_endings = { unix = "LF", dos = "CRLF", mac = "CR", }
        local text = vim.bo.fileformat
        if text == '' then
          return ''
        end
        local icon = line_endings[text]
        if icon == '' then
          return text
        end
        return icon
      end

      local get_filesize = function()
        -- stackoverflow, compute human readable file size
        local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
        local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize < 1024 then
            return fsize..suffix[1]
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))
        return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
      end

      local min_section_fileinfo = function()
        local encoding = vim.bo.fileencoding or vim.bo.encoding
        local format = file_format()
        local size = get_filesize()
        return string.format('%s %s %s', string.upper(encoding), format, size)
      end

      local set_cust_hl = function(name, data)
        local color_bg = vim.api.nvim_get_hl(0, {name = name})
        local rev_name = 'rev_' .. name
        vim.api.nvim_set_hl(0, rev_name, { fg = color_bg.bg })
      end

      local separator_right  = ''
      local separator_left = ''

      set_cust_hl('MiniStatuslineModeNormal',  { link = 'Cursor' })
      set_cust_hl('MiniStatuslineModeInsert',  { link = 'DiffChange' })
      set_cust_hl('MiniStatuslineModeVisual',  { link = 'DiffAdd' })
      set_cust_hl('MiniStatuslineModeReplace', { link = 'DiffDelete' })
      set_cust_hl('MiniStatuslineModeCommand', { link = 'DiffText' })
      set_cust_hl('MiniStatuslineModeOther',   { link = 'IncSearch' })
      set_cust_hl('MiniStatuslineDevinfo',     { link = 'StatusLine' })

      require('mini.statusline').setup({
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git           = MiniStatusline.section_git({ trunc_width = 120 })
            local fileinfo      = min_section_fileinfo()
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            local location      = '%p%%'
            local search        = MiniStatusline.section_searchcount({ trunc_width = 120 })

            local git_separator_left, git_separator_right
            if git == '' then
              git_separator_left  = ''
              git_separator_right = ''
            else
              git_separator_left  = separator_left
              git_separator_right = separator_right
            end

            return MiniStatusline.combine_groups({
              { hl = mode_hl, strings = { string.upper(mode) } },
              { hl = 'rev_' .. mode_hl },
              separator_right,

              { hl = 'rev_MiniStatuslineDevinfo' },
              git_separator_left,
              { hl = 'MiniStatuslineDevinfo', strings = { git } },
              { hl = 'rev_MiniStatuslineDevinfo' },
              git_separator_right,

              { hl = 'rev_MiniStatuslineDevinfo' },
              separator_left,
              { hl = 'MiniStatuslineDevinfo', strings = { get_filetype_icon() .. ' ' .. filename } },
              { hl = 'rev_MiniStatuslineDevinfo' },
              separator_right,

              '%=', -- End left alignment

              { hl = 'rev_MiniStatuslineDevinfo' },
              separator_left,
              { hl = 'MiniStatuslineDevinfo', strings = { fileinfo } },
              { hl = 'rev_MiniStatuslineDevinfo' },
              separator_right,

              { hl = 'rev_' .. mode_hl },
              separator_left,
              { hl = mode_hl, strings = { search, location } },
            })
          end,
          inactive = nil,
        }
      })
    end,},
}
