return {
  {
    "nvchad/minty",
    lazy = true,
    dependencies = {
      "nvchad/volt",
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
