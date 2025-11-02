-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- vim.keymap.set("n", "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "RSpec on file" })
-- vim.keymap.set("n", "<leader>tl", ":lua require('neotest').run.run()<CR>", { desc = "RSpec on test" })
-- vim.keymap.set("n", "<leader>to", ":lua require('neotest').output.open({enter = true})<CR>", { desc = "RSpec output" })
-- vim.keymap.set("n", "<leader>tp", ":lua require('neotest').summary.open()<CR>", { desc = "RSpec summary" })
-- vim.keymap.set("n", "<leader>td", ":lua require('neotest').run.run({ strategy = 'dap' })<CR>", { desc = "RSpec Debug" })

local fzf = require("fzf-lua")

local function references_async()
  local params = vim.lsp.util.make_position_params()
  params.context = { includeDeclaration = false }

  vim.lsp.buf_request_all(0, "textDocument/references", params, function(results)
    local qf_items = {}

    for client_id, response in pairs(results or {}) do
      local locations = response and response.result
      if locations then
        local client = vim.lsp.get_client_by_id(client_id)
        local offset_encoding = client and client.offset_encoding or "utf-16"
        local items = vim.lsp.util.locations_to_items(locations, offset_encoding)
        vim.list_extend(qf_items, items)
      end
    end

    if vim.tbl_isempty(qf_items) then
      vim.notify("No references found", vim.log.levels.INFO)
      return
    end

    vim.fn.setqflist({}, " ", { items = qf_items, title = "LSP References" })
    fzf.quickfix({ prompt = "LSP References> " })
  end)
end

vim.api.nvim_del_keymap("n", "<M-k>")
vim.api.nvim_del_keymap("n", "<M-j>")
vim.api.nvim_del_keymap("v", "<M-k>")
vim.api.nvim_del_keymap("v", "<M-j>")
vim.api.nvim_del_keymap("i", "<M-k>")
vim.api.nvim_del_keymap("i", "<M-j>")

vim.keymap.set("n", "<leader>gr", references_async, { desc = "References (async fzf)" })
