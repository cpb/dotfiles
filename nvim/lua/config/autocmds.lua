-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

vim.api.nvim_create_autocmd({ "TextChanged", "BufEnter" }, {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "prompt" then
      vim.cmd("normal! G")
    end
  end,
})
