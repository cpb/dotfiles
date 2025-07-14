local lspconfig = require("lspconfig")
-- lspconfig.sorbet.setup({
--   cmd = { vim.fn.expand("~/.rbenv/shims/srb"), "tc", "--lsp" },
-- })
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false,
          init_options = {
            formatter = "rubocop_internal",
          },
          cmd = { "bundle", "exec", "ruby-lsp" },
        },
      },
    },
  },
}
