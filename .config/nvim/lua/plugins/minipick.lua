return {
  {
    "echasnovski/mini.pick",
    dependencies = {
      "echasnovski/mini.extra"
    },
    cmd = "Pick",
    keys = {
      { "<leader>ff", function() require('mini.pick').builtin.files({ tool = 'git' }) end },
      { "<leader>fr", function() require('mini.extra').pickers.oldfiles() end },
      { "<leader>fg", function() require('mini.pick').builtin.grep_live() end },
    },
  },
}
