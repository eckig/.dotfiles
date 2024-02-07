return {
  { 'echasnovski/mini.nvim', version = false, config = function()
      require('mini.tabline').setup()

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

      local get_filetype_icon = function()
        local file_name, file_ext = vim.fn.expand('%:t'), vim.fn.expand('%:e')
        return require('nvim-web-devicons').get_icon(file_name, file_ext, { default = true })
      end

      local min_section_fileinfo = function()
        local filetype = vim.bo.filetype

        if (filetype == '') then return '' end

        local icon = get_filetype_icon()
        if icon ~= '' then filetype = string.format('%s %s', icon, filetype) end

        local encoding = vim.bo.fileencoding or vim.bo.encoding
        local format = vim.bo.fileformat

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
            local search        = MiniStatusline.section_searchcount({ trunc_width = 120 })
            local dir           = string.format(' %s', vim.fn.fnamemodify(get_root_dir(), ':t'))

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                  strings = { mode } },
              { hl = 'MiniStatuslineDevinfo',  strings = { git } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { dir } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl,                  strings = { search, location } },
            })
          end,
          inactive = nil,
        }
      })

    end,},
}
