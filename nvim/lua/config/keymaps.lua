-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- vim.keymap.set("n", "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "RSpec on file" })
-- vim.keymap.set("n", "<leader>tl", ":lua require('neotest').run.run()<CR>", { desc = "RSpec on test" })
-- vim.keymap.set("n", "<leader>to", ":lua require('neotest').output.open({enter = true})<CR>", { desc = "RSpec output" })
-- vim.keymap.set("n", "<leader>tp", ":lua require('neotest').summary.open()<CR>", { desc = "RSpec summary" })
-- vim.keymap.set("n", "<leader>td", ":lua require('neotest').run.run({ strategy = 'dap' })<CR>", { desc = "RSpec Debug" })

vim.api.nvim_del_keymap("n", "<M-k>")
vim.api.nvim_del_keymap("n", "<M-j>")
vim.api.nvim_del_keymap("v", "<M-k>")
vim.api.nvim_del_keymap("v", "<M-j>")
vim.api.nvim_del_keymap("i", "<M-k>")
vim.api.nvim_del_keymap("i", "<M-j>")
