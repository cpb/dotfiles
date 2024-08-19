local function setup_ruby_configuration(dap)
  local base_config = {
    type = "ruby",
    request = "attach",
    options = { source_filetype = "ruby" },
    error_on_failure = true,
    localfs = true,
  }
  local run_config = vim.tbl_extend("force", base_config, { waiting = 1000, random_port = true })
  local function extend_base_config(config)
    return vim.tbl_extend("force", base_config, config)
  end
  local function extend_run_config(config)
    return vim.tbl_extend("force", run_config, config)
  end
  dap.configurations.ruby = {
    extend_run_config({
      name = "debug current file",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "ruby" },
      current_file = true,
    }),
    extend_run_config({
      name = "run rails",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rails", "s" },
    }),
    extend_run_config({
      name = "run rspec current file",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rspec" },
      current_file = true,
    }),
    extend_run_config({
      name = "run rspec current_file:current_line",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rspec" },
      current_line = true,
    }),
    extend_run_config({
      name = "TEST run rspec current_file:current_line",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rspec" },
      current_line = true,
      error_on_failure = false,
      stdout_handler = function(chunk)
        print(chunk)
      end,
    }),
    extend_run_config({
      name = "run rspec",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rspec" },
    }),
    extend_run_config({ name = "bin/dev", command = "bin/dev" }),
    extend_base_config({ name = "attach existing (port 38698)", port = 38698, waiting = 0 }),
    extend_base_config({ name = "attach existing (pick port)", waiting = 0 }),
  }
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "cpb/nvim-dap-ruby",
        dev = true,
        dir = "/Users/cpb/oss/nvim-dap-ruby",
      },
    },
    config = function()
      require("dap-ruby").setup()
      local dap = require("dap")

      setup_ruby_configuration(dap)
    end,
  },
}
