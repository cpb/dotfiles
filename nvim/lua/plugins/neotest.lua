-- Attempts to get mono repo working
-- found more than just neotest wasn't working out for it
-- local function get_rspec_cmd(flags)
--   -- Get the root directory using neotest-rspec's root function
--   local root_dir = require("neotest-rspec").root(vim.fn.expand("%:p"))
--
--   -- Base rspec command
--   local rspec_cmd = { "bundle", "exec", "rspec" }
--
--   -- Append the provided flags
--   if flags and #flags > 0 then
--     rspec_cmd = vim.tbl_flatten({ rspec_cmd, flags })
--   end
--
--   -- Return the command wrapped in a shell execution that changes the directory
--   return { "sh", "-c", "cd " .. vim.fn.shellescape(root_dir) .. " && " .. table.concat(rspec_cmd, " ") }
-- end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      {
        "cpb/neotest-rspec",
        branch = "cpb/update-dap-strategy",
      },
      "zidhuss/neotest-minitest",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec")({
            rspec_cmd = function()
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rdbg",
                "--nonstop",
                "-c",
                "--",
                "rspec",
              })
            end,
          }),
          require("neotest-minitest")({
            test_cmd = function()
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rdbg",
                "--nonstop",
                "-c",
                "--",
                "rails",
                "test",
              })
            end,
          }),
          require("neotest-jest")({
            jestCommand = "yarn test",
            jestConfigFile = "jest.config.js",
            cwd = function()
              return vim.fn.getcwd()
            end,
            logLevel = "DEBUG",
          }),
        },
      })
    end,
  },
}
