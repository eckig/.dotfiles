return {
  {
    "nvchad/minty",
    lazy = true,
    dependencies = {
      "nvchad/volt",
    },
    cmd = {
      "Shades",
      "Huefy"
    },
    keys = {
      {
        "<leader>co",
        function()
          require("minty.huefy").open( { border = true } )
        end
      },
    },
  }
}
