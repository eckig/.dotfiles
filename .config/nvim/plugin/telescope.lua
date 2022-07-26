local previewers = require("telescope.previewers")

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  -- ignore files bigger than a threshold
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 200000 then
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
    file_ignore_patterns = {'%.jpeg', '%.jpg', '%.doc', '%.pdf', '%.class', '%.docx', '%.jar', '%.zip', '%.exe', '%.apk', '%.pptx', '%.ppt', '%.png', '%.ico', '%.xls', '%.xlsx', '%.vsdx', '%.jks', '%.vds'},
  },
})

require("telescope").load_extension("fzy_native")

vim.keymap.set( "n", "<leader>ff", function() require('telescope.builtin').git_files() end, { noremap = true } )
vim.keymap.set( "n", "<leader>fr", function() require('telescope.builtin').oldfiles() end, { noremap = true } )
vim.keymap.set( "n", "<leader>fg", function() require('telescope.builtin').live_grep() end, { noremap = true } )
