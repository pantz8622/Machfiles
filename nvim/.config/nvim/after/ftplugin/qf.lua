local keymap = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

keymap(0, "n", "<space>", ":lua require('ctoggle').cc_wo_focus()<cr>", opts) -- from ctoggle
keymap(0, "n", "<cr>", ":cc<cr>:cclose<cr>", opts)
