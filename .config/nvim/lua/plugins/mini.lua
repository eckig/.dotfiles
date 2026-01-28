return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.cursorword").setup()
      require("mini.tabline").setup()
      require("mini.statusline").setup()
      require("mini.cmdline").setup()
      require("mini.git").setup()
      require("mini.notify").setup()
      require("mini.pick").setup()
      require("mini.visits").setup()
      require("mini.extra").setup()
      require('mini.trailspace').setup()

      -- Keymap
      local map_multistep = require('mini.keymap').map_multistep
      map_multistep('i', '<Tab>',   { 'pmenu_next' })
      map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
      map_multistep('i', '<CR>',    { 'pmenu_accept' })

      -- Completion
      -- Customize post-processing of LSP responses for a better user experience.
      -- Don't show 'Text' suggestions (usually noisy) and show snippets last.
      local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
      local process_items = function(items, base)
        return MiniCompletion.default_process_items(items, base, process_items_opts)
      end
      require('mini.completion').setup(
      {
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

      -- Advertise to servers that Neovim now supports certain set of completion and
      -- signature features through 'mini.completion'.
      vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })

      -- Hipatterns
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup(
      {
        highlighters =
        {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      -- Align (properties file by '=')
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

      -- Icons
      local ext3_blocklist = { scm = true, txt = true, yml = true }
      local ext4_blocklist = { json = true, yaml = true }
      require('mini.icons').setup({
        use_file_extension = function(ext, _)
          return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
        end,
      })
      MiniIcons.tweak_lsp_kind()

      -- Indentscope
      local var indentscope = require('mini.indentscope')
      indentscope.setup(
      {
        draw = { animation = indentscope.gen_animation.none() }
      })

      -- Starter
      require("mini.starter").setup(
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
      })
    end,
  },

}
