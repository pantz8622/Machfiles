local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.g.mapleader = ","
-- vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Window&Buffer Control
keymap("n", "<c-q>", ":q<cr>", opts)
keymap("n", "<c-s-q>", ":q!<cr>", opts)
keymap("n", "<c-s>", ":w<cr>", opts)
keymap("n", "g<c-w>", "<c-w>", opts)

-- Quickfix Control
keymap("n", "]q", ":cnewer<cr>", opts)
keymap("n", "[q", ":colder<cr>", opts)

-- Folding
keymap("n", "<space>", "za", opts)
keymap("n", "<S-space>", "zA", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:move .+1<CR>", opts)
keymap("n", "<A-k>", "<Esc>:move .-2<CR>", opts)

-- QuickOp
keymap("n", "s", "c", opts)
keymap("n", "ss", "cc", opts)
keymap("n", "S", "C", opts)
keymap("n", "sw", "ciw", opts)
keymap("n", "sW", "ciW", opts)
keymap("n", "s'", "ci'", opts)
keymap("n", 's"', 'ci"', opts)
keymap("n", "s(", "ci(", opts)
keymap("n", "s[", "ci[", opts)
keymap("n", "s{", "ci{", opts)
keymap("n", "s<", "ci<", opts)

local ops = { 'v', 'd', 'y', '~' }
for _, op in ipairs(ops) do
  keymap("n", op .. "w", op .. "iw", opts)
  keymap("n", op .. "W", op .. "iW", opts)
  keymap("n", op .. "'", op .. "i'", opts)
  keymap("n", op .. '"', op .. 'i"', opts)
  keymap("n", op .. "(", op .. "i(", opts)
  keymap("n", op .. "[", op .. "i[", opts)
  keymap("n", op .. "{", op .. "i{", opts)
  keymap("n", op .. "<", op .. "i<", opts)
end

-- Visual --
-- Folding
keymap("v", "<space>", "za", opts)
keymap("v", "<S-space>", "zA", opts)
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":move .+1<CR>", opts)
keymap("v", "<A-k>", ":move .-2<CR>", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

