local comment = require 'Comment'

comment.setup {
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
        line = 'cc',
        block = 'CC',
    },
    opleader = {
        line = 'c',
        block = 'C',
    },
    mappings = {
        basic = true,
        extra = false,
    },
    pre_hook = nil,
    post_hook = nil,
}

-- Cowork with Gitsings.nvim
local opts = { noremap = false, silent = true }
if pcall(require, 'gitsigns') then
  vim.keymap.set("n", "cg", ":Gitsigns select_hunk<CR><Plug>(comment_toggle_linewise_visual)", opts)
end

-- Cowork with vim-illuminate
if pcall(require, 'illuminate') then
  vim.keymap.set("n", "cr", ":lua require('illuminate').textobj_select()<cr><Plug>(comment_toggle_linewise_visual)", opts)
end
