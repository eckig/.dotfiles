local git_sign_icon = "▎"
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = git_sign_icon },
        change = { text = git_sign_icon },
        delete = { text = git_sign_icon },
        topdelete = { text = git_sign_icon },
        changedelete = { text = git_sign_icon },
        untracked = { text = git_sign_icon },
      },
    },
  },
}
