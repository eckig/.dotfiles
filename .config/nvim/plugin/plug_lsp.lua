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
end)
