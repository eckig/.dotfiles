vim.lsp.config("yamlls", {
  filetypes = { "yaml", "yml" },
  settings = {
    yaml = {
      format = {
        enable = true,
        singleQuote = true,
        printWidth = 120,
      },
      hover = true,
      completion = true,
      validate = true,
      schemas = {
        kubernetes = {
          "*.yml",
          "*.yaml",
        },
      },
      schemaStore = { enable = false, url = "" },
    },
  },
})
