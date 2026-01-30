local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add(
  {
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })

  local languages =
  {
    'bash',
    'c',
    'diff',
    'html',
    'java',
    'javascript',
    'json',
    'lua',
    'luadoc',
    'luap',
    'markdown',
    'markdown_inline',
    'query',
    'regex',
    'toml',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
  }
  require('nvim-treesitter').install(languages)

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev)
    vim.treesitter.start(ev.buf)
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
  end
  _Z.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)
