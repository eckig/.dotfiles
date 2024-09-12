vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
  pattern = "*",
  command = "setlocal number relativenumber",
})
vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
  pattern = "*",
  command = "setlocal number norelativenumber",
})

-- always open quickfix window automatically.
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = vim.api.nvim_create_augroup("AutoOpenQuickfix", { clear = true }),
  pattern = { "[^l]*" },
  command = "cwindow",
})

-- disable features on big files
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function(args)
    local is_big_file = require("utils").is_big_file
    local bigfile_detected = is_big_file(args.buf)
    if bigfile_detected then
      vim.cmd("syntax clear")
      vim.opt_local.syntax = "OFF"
      vim.opt_local.foldmethod = "manual"
    end
  end,
})

-- replace umlauts in properties
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.properties" },
  callback = function(event)
    vim.cmd(":set noignorecase")
    vim.cmd(":%s/ä/\\\\u00E4/ge")
    vim.cmd(":%s/Ä/\\\\u00C4/ge")
    vim.cmd(":%s/ö/\\\\u00D6/ge")
    vim.cmd(":%s/Ö/\\\\u00F6/ge")
    vim.cmd(":%s/ü/\\\\u00FC/ge")
    vim.cmd(":%s/Ü/\\\\u00DC/ge")
    vim.cmd(":%s/ß/\\\\u00DF/ge")
  end,
})

-- autosave
vim.api.nvim_create_autocmd(
  { "FocusLost", "ModeChanged", "TextChanged", "BufEnter" },
  { desc = "autosave", pattern = "*", command = "silent! update" }
)
