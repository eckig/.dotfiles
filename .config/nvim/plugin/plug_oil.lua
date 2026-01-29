local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add('stevearc/oil.nvim')
  require("oil").setup(
  {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = true,
    view_options = {
      show_hidden = true,
    },
  })
end)
