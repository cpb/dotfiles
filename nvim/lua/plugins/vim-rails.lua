return {
  "tpope/vim-rails",
  ft = { "ruby", "eruby", "haml", "slim" },
  dependencies = {
    "tpope/vim-bundler",
  },
  keys = {
    { "<leader>ta", ":A<CR>", desc = "Alternate file (test/impl)" },
    { "<leader>tv", ":AV<CR>", desc = "Alternate file (vsplit)" },
    { "<leader>ts", ":AS<CR>", desc = "Alternate file (split)" },
  },
}
