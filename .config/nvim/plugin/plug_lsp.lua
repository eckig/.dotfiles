local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

now_if_args(function()
  add({ 'https://github.com/mason-org/mason.nvim' })
  require('mason').setup()

  vim.lsp.enable(
  {
    "yamlls",
    "lua_ls"
  })

  vim.diagnostic.config(
  {
    signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },
    underline = { severity = { min = 'HINT', max = 'ERROR' } },
    virtual_lines = false,
    virtual_text =
    {
      current_line = true,
      severity = { min = 'ERROR', max = 'ERROR' },
    },
  })
end)
