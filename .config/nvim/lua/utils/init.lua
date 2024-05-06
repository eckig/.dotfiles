local lib = {}

function lib.is_big_file(bufnr)
  if bufnr == nil then bufnr = 0 end
  local filesize = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
  local nlines = vim.api.nvim_buf_line_count(bufnr)
  local big = (filesize > vim.g.big_file.size) or (nlines > vim.g.big_file.lines)
  return big
end

return lib
