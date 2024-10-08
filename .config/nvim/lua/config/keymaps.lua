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
map("n", "<C-H>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-J>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-K>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-L>", "<C-w>l", { desc = "Go to Right Window", remap = true })
