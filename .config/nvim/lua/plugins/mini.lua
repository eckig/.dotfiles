return {
  {
    "nvim-mini/mini.cursorword",
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup()
    end,
  },

  {
    'nvim-mini/mini.tabline',
    version = false,
    config = function()
      require("mini.tabline").setup()
    end,
  },

  {
    'nvim-mini/mini.statusline',
    version = false,
    config = function()
      require("mini.statusline").setup()
    end,
  },

  {
    'nvim-mini/mini.cmdline',
    version = false,
    config = function()
      require("mini.cmdline").setup()
    end,
  },

  {
    'nvim-mini/mini.keymap',
    version = false,
    config = function()
      local map_multistep = require('mini.keymap').map_multistep
      map_multistep('i', '<Tab>',   { 'pmenu_next' })
      map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
      map_multistep('i', '<CR>',    { 'pmenu_accept' })
    end,
  },

  {
    "nvim-mini/mini.completion",
    version = false,
    config = function()
      -- Customize post-processing of LSP responses for a better user experience.
      -- Don't show 'Text' suggestions (usually noisy) and show snippets last.
      local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
      local process_items = function(items, base)
        return MiniCompletion.default_process_items(items, base, process_items_opts)
      end
      require('mini.completion').setup({
        lsp_completion = {
          -- Without this config autocompletion is set up through `:h 'completefunc'`.
          -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
          -- (sets up only when needed) and makes it possible to use `<C-u>`.
          source_func = 'omnifunc',
          auto_setup = false,
          process_items = process_items,
        },
      })

      -- disable completion in certain files
      local f = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == 'snacks_picker_list' or ft == 'help' then return end
        vim.b[args.buf].minicompletion_disable = true
      end
      vim.api.nvim_create_autocmd('Filetype', { callback = f })

      -- link completion with LSP
      local on_attach = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
      end

      local gr = vim.api.nvim_create_augroup('custom-config', {})
      local new_autocmd = function(event, pattern, callback, desc)
        local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
        vim.api.nvim_create_autocmd(event, opts)
      end

      new_autocmd('LspAttach', nil, on_attach, "Set 'omnifunc'")

      -- Advertise to servers that Neovim now supports certain set of completion and
      -- signature features through 'mini.completion'.
      vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
    end,
  },

  {
    'nvim-mini/mini-git',
    version = false,
    config = function()
      require("mini.git").setup()
    end,
  },

  {
    "nvim-mini/mini.align",
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
    "nvim-mini/mini.hipatterns",
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
