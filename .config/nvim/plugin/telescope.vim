
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

lua << END
local previewers = require("telescope.previewers")

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  -- ignore files bigger than a threshold
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require("telescope").setup({
        defaults = {
                file_sorter = require("telescope.sorters").get_fzy_sorter,
                color_devicons = true,
                buffer_previewer_maker = new_maker,
        },
})

require("telescope").load_extension("fzy_native")

END

