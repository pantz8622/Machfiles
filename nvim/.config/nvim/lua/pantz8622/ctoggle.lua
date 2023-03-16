local status_ok, ctoggle = pcall(require, "ctoggle")
if not status_ok then
  return
end

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("n", "<leader>tq", ":lua require('ctoggle').ctoggle()<cr>", opts)

