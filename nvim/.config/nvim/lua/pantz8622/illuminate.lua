local illuminate = require('illuminate')

illuminate.configure({
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    delay = 100,
    filetypes_denylist = { },
    filetypes_allowlist = { },
})

-- keympas
local opts = { noremap = true, silent = true }

-- Navigations
vim.keymap.set("n", "]r", ":lua require('illuminate').goto_next_reference()<cr>", opts)
vim.keymap.set("n", "[r", ":lua require('illuminate').goto_prev_reference()<cr>", opts)

-- Quick Ops
vim.keymap.set("n", "vr", ":lua require('illuminate').textobj_select()<cr>", opts)
vim.keymap.set("n", "sr", ":lua require('illuminate').textobj_select()<cr>c", opts)

local ops = { 'd', 'y', '~' }
for _, op in ipairs(ops) do
  vim.keymap.set("n", op .. "r", ":lua require('illuminate').textobj_select()<cr>" .. op, opts)
end
