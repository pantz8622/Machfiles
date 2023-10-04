local ctoggle = require('ctoggle')

ctoggle.setup()

vim.api.nvim_create_autocmd('BufRead', {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].filetype == 'qf' then
      local opts = { noremap = true, silent = true, buffer = 0 }
      vim.keymap.set("n", "<space>", function() ctoggle.cc({focus = false}) end, opts)
      vim.keymap.set("n", "<cr>", function() ctoggle.cc({focus = true}) end, opts)
    end
  end
})

-- Keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>q", ctoggle.ctoggle, opts)
vim.keymap.set("n", "]q", ctoggle.cnext, opts)
vim.keymap.set("n", "[q", ctoggle.cprev, opts)
