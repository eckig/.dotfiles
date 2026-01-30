local root_markers1 =
{
  '.emmyrc.json',
  '.luarc.json',
  '.luarc.jsonc',
}
local root_markers2 =
{
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
}

return
{
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = vim.list_extend(vim.list_extend(root_markers1, root_markers2), { '.git' }),
  on_attach = function(client, buf_id)
    client.server_capabilities.completionProvider.triggerCharacters = { '.', ':', '#', '(' }
  end,
  settings =
  {
    Lua =
    {
      codeLens =  { enable = true },
      hint =      { enable = true, semicolon = 'Disable' },
      runtime =
      {
        version = 'LuaJIT',
        path    = { vim.split(package.path, ';') },
      },
      workspace =
      {
        checkThirdParty = false,
        ignoreSubmodules = true,
        library = { vim.env.VIMRUNTIME, },
      },
    },
  },
}

