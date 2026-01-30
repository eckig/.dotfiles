local now, later = MiniDeps.now, MiniDeps.later

-- Icons
now(function()
  -- Set up to not prefer extension-based icon for some extensions
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require('mini.icons').setup({
    use_file_extension = function(ext, _)
      return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
    end,
  })
  later(MiniIcons.tweak_lsp_kind)
end)

-- Notifications
now(function() require('mini.notify').setup() end)

-- Statusline
now(function() require('mini.statusline').setup() end)

-- Tabline
now(function() require('mini.tabline').setup() end)

-- Extra 'mini.nvim' functionality.
later(function() require('mini.extra').setup() end)

-- Command line
later(function() require('mini.cmdline').setup() end)

-- Git
later(function() require('mini.git').setup() end)

-- Picker
later(function() require('mini.pick').setup() end)

-- Trailing space
later(function() require('mini.trailspace').setup() end)

-- File visits
later(function() require('mini.visits').setup() end)

-- Cursorword
later(function() require('mini.cursorword').setup() end)

-- Indent scope
later(function()
  local var indentscope = require('mini.indentscope')
  indentscope.setup(
  {
    draw = { animation = indentscope.gen_animation.none() }
  })
end)

-- Files
require('mini.files').setup(
{
  mappings =
  {
    go_in_plus = '<CR>',
  },
})

-- Highlight patterns
later(function()
  local hipatterns = require('mini.hipatterns')
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup(
  {
    highlighters =
    {
      -- Highlight a fixed set of common words. Will be highlighted in any place,
      -- not like "only in comments".
      fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
      hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
      todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
      note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),

      -- Highlight hex color string (#aabbcc) with that color as a background
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

-- Completion and signature help
later(function()
  -- Don't show 'Text' suggestions (usually noisy) and show snippets last.
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
  end
  require('mini.completion').setup({
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = process_items,
    },
  })

  local on_attach = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end
  _Z.new_autocmd('LspAttach', nil, on_attach, "Set 'omnifunc'")

  vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

-- Align (properties file by '=')
later(function()
  local var align = require("mini.align")
  align.setup(
  {
    options =
    {
      split_pattern = "=",
      justify_side = "left",
      merge_delimiter = " ",
    },
    steps =
    {
      pre_justify = { align.gen_step.trim() },
    },
  })
end)

-- Keymap
later(function()
  require('mini.keymap').setup()
  -- Navigate 'mini.completion'
  MiniKeymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
  MiniKeymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
  MiniKeymap.map_multistep('i', '<CR>', { 'pmenu_accept' })
end)

-- Start screen
now(function() require('mini.starter').setup(
{
          header = [[
⠀⠀⠀⣠⣶⣆⠀⠀⠀⠀⠀⠀⠀⠀⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⣠⣾⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣾⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢰⡄⣠⠴⠶⠶⣤⡀⠀⠀⢀⣠⠴⠶⠶⢤⡀⠀⠀⠀⣠⠴⠶⠶⢦⣄⠀⢰⣶⣶⠀⠀⠀⠀⣰⣶⡶⢰⣶⣶⠀⠀⣶⣶⣤⣶⣿⣷⣦⣠⣶⣾⣿⣷⣦⡀
⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣷⡀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢸⡏⠀⠀⠀⠀⠈⣷⠀⢠⡞⠁⠀⠀⠀⠀⠹⡆⢀⡾⠁⠀⠀⠀⠀⠘⣷⡀⢻⣿⣧⠀⠀⢠⣿⣿⠁⢸⣿⣿⠀⠀⣿⣿⠋⠀⠀⢹⣿⣿⠋⠀⠈⢻⣿⣷
⣿⣿⣿⣿⣿⠀⠻⣿⣿⣿⣿⣿⣆⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣿⠀⢸⡗⠒⠒⠒⠒⠒⠚⠃⢸⡇⠀⠀⠀⠀⠀⠀⢸⡇⠀⢿⣿⡆⢀⣿⣿⠃⠀⢸⣿⣿⠀⠀⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿
⣿⣿⣿⣿⣿⠀⠀⠙⣿⣿⣿⣿⣿⣧⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣿⠀⠸⣇⠀⠀⠀⠀⠀⠀⠀⠸⣧⠀⠀⠀⠀⠀⠀⣾⠃⠀⠈⣿⣿⣼⣿⠇⠀⠀⢸⣿⣿⠀⠀⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿
⣿⣿⣿⣿⣿⠀⠀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣿⠀⠀⠙⠷⣤⣀⣀⣤⠶⠂⠀⠙⠷⣤⣀⣀⣤⠾⠃⠀⠀⠀⠘⣿⣿⠏⠀⠀⠀⢸⣿⣿⠀⠀⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿
⢿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠙⢿⣿⣿⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠙⢿⠀⠀⠀⠀⠀⠀⠀⠀⠻⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
}) end)
