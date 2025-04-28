-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_user_command("LspCapabilities", function()
  local cur_buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_active_clients({ bufnr = cur_buf })

  for _, client in pairs(clients) do
    if client.name ~= "null-ls" then
      local capabilities_list = {}
      for key, value in pairs(client.server_capabilities) do
        if value and key:find("Provider") then
          local capability = key:gsub("Provider$", "")
          table.insert(capabilities_list, "- " .. capability)
        end
      end
      table.sort(capabilities_list)
      local msg = "# " .. client.name .. "\n" .. table.concat(capabilities_list, "\n")
      print(msg)
    end
  end
end, {})
