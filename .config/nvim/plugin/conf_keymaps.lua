local map = vim.keymap.set

map("n", "qq", "<cmd>bd<cr>")

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-H>", "<C-w>h", { desc = "Go to Left Window",  remap = true })
map("n", "<C-J>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-K>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-L>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Picker
map("n", "<leader>fr", '<Cmd>Pick visit_paths cwd=""<CR>', { desc = "Recent" })
map("n", "<leader>/",  '<Cmd>Pick grep_live<CR>', { desc = "Grep" })
map("n", "<leader>ff", '<Cmd>Pick files<CR>', { desc = "Find Files" })

-- Oil
map("n", "<leader>fd", function() require("oil").open_float(vim.fn.expand("%:p:h")) end, { desc = "Oil" })

vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
map("n", "<leader>cc", "<cmd>Cppath<cr>")
