local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<c-w>", ":Bd<cr>", opts)
keymap("n", "<c-s-w>", ":Bd!<cr>", opts)
