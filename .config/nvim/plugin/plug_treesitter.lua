local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add(
  {
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    checkout = 'master',
  })
  require("nvim-treesitter.configs").setup(
  {
    highlight =
    {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    ensure_installed =
    {
      "bash",
      "c",
      "diff",
      "html",
      "java",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "query",
      "regex",
      "toml",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
  })
end)
