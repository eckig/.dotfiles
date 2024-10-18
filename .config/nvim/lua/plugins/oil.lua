return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      {
        "<leader>fd",
        function()
          require("oil").open_float(vim.fn.expand("%:p:h"))
        end,
      },
    },
    -- lazy load oil.nvim
    -- see https://github.com/kevinm6/nvim/blob/nvim/lua/plugins/editor/oil.lua
    init = function(p)
      if vim.fn.argc() == 1 then
        local argv = tostring(vim.fn.argv(0))
        local stat = vim.loop.fs_stat(argv)

        local remote_dir_args = vim.startswith(argv, "ssh") or vim.startswith(argv, "sftp") or vim.startswith(argv, "scp")

        if stat and stat.type == "directory" or remote_dir_args then
          require("lazy").load { plugins = { p.name } }
        end
      end
      if not require("lazy.core.config").plugins[p.name]._.loaded then
        vim.api.nvim_create_autocmd("BufNew", {
          pattern = "*/", -- load on dirs
          callback = function()
            require("lazy").load { plugins = { p.name } }
            return true
          end,
        })
      end
    end,
    },
}
