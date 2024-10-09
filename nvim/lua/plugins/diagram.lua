return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = { "luarocks.nvim" },
    config = function() end,
  },
  {
    "3rd/diagram.nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    config = function()
      require("image").setup()
      require("diagram").setup({})
    end,
  },
}
