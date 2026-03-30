local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

-- Install "Buildtools für Visual Studio"
-- "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

now_if_args(function()
  -- Define hook to update tree-sitter parsers after plugin is updated
  local ts_update = function() vim.cmd('TSUpdate') end
  Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  add( {'https://github.com/nvim-treesitter/nvim-treesitter'} )

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
  Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
  require('nvim-treesitter').install(languages)

end)
