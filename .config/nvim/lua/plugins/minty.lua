return {
  {
    "nvzone/minty",
    lazy = true,
    dependencies = {
      "nvzone/volt",
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
