vim.wo.foldmethod = 'expr'
vim.wo.foldenable = true
vim.wo.foldexpr = 'match(getline(v:lnum), "^+++\\\\|^---\\\\|^!!!") < 0'
