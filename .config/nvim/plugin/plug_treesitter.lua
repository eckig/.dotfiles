local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Install "Buildtools für Visual Studio"
-- "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

local languages =
{
  'c',
  'diff',
  'html',
  'java',
  'javascript',
  'json',
  'lua',
  'markdown',
  'regex',
  'toml',
  'vim',
  'xml',
  'yaml',
}

now(function()
  add(
  {
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })

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

later(function()
  require('nvim-treesitter').install(languages)
end)
