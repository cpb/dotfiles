-- Launch-time env vars (read on VimEnter):
--   CLAUDECODE_ARGS   — extra flags appended to `claude` (e.g. --add-dir, --permission-mode)
--   CLAUDECODE_PROMPT — initial prompt; auto-shellescape'd so backticks/quotes are safe
-- If either is set, the panel auto-toggles open at startup with those args.
-- Captured once at module load and cleared from vim.env so child nvim processes
-- (e.g. Claude Code's Ctrl-G prompt editor) don't inherit them and re-open a panel.
local _captured_args = (function()
  local args = vim.env.CLAUDECODE_ARGS or ""
  local prompt = vim.env.CLAUDECODE_PROMPT
  vim.env.CLAUDECODE_ARGS = nil
  vim.env.CLAUDECODE_PROMPT = nil
  if prompt and prompt ~= "" then
    args = (args ~= "" and (args .. " ") or "") .. vim.fn.shellescape(prompt)
  end
  return args ~= "" and args or nil
end)()

local function startup_args()
  return _captured_args
end

return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    event = startup_args() and "VimEnter" or nil,
    opts = {
      auto_start = true,
      track_selection = true, -- sends active selection as context automatically
      terminal = {
        split_side = "right",
        split_width_percentage = 0.35,
        provider = "snacks", -- use snacks.nvim terminal (already installed)
        auto_close = true,
      },
      diff_opts = {
        layout = "vertical",
        open_in_new_tab = false,
        keep_terminal_focus = false,
      },
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      {
        "<leader>aR",
        function()
          local term = require("claudecode.terminal")
          local bufnr = term.get_active_terminal_bufnr()
          if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
            vim.api.nvim_buf_delete(bufnr, { force = true })
          end
          vim.schedule(function()
            term.simple_toggle({}, startup_args())
          end)
        end,
        desc = "Restart Claude Code (re-uses launch args)",
      },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer to Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", desc = "Send selection to Claude", mode = "v" },
      { "<leader>as", "<cmd>ClaudeCodeAdd<cr>", desc = "Add file to Claude (tree)" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
    config = function(_, opts)
      require("claudecode").setup(opts)
      local args = startup_args()
      if args then
        vim.schedule(function()
          require("claudecode.terminal").simple_toggle({}, args)
        end)
      end
    end,
  },
}
