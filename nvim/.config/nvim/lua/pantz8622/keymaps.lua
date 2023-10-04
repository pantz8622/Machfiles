-- Buffer Deletion
local bdelete = function (opts) -- fallback to builtin bdelete if bbye is not installed
  if opts == nil then opts = { } end
  if opts.bufnr == nil then opts.bufnr = vim.api.nvim_get_current_buf() end
  if opts.force == nil then opts.force = false end

  local cmd = 'bdelete'
  if opts.force then
    cmd = cmd .. '!'
  end
  vim.cmd(cmd .. ' ' .. opts.bufnr)
end
local has_bbye, bbye = pcall(require, 'vim-bbye')
if has_bbye then
  bdelete = function (opts) bbye.bdelete(opts) end
end

-- Global Keympas
local opts = { noremap = true, silent = true }
vim.g.mapleader = "," --Remap space as leader key

-- Navigation
vim.keymap.set("i", "<A-j>", "<down>", opts)
vim.keymap.set("i", "<A-k>", "<up>", opts)
vim.keymap.set("i", "<A-h>", "<left>", opts)
vim.keymap.set("i", "<A-l>", "<right>", opts)

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Window & Buffer Control
vim.keymap.set("n", "<c-q>", ":q<cr>", opts)
vim.keymap.set("n", "<c-s-q>", ":qall!<cr>", opts)
vim.keymap.set("n", "<c-s>", ":w<cr>", opts)
vim.keymap.set("n", "<c-w>", function () bdelete({force = false}) end, opts)
vim.keymap.set("n", "<c-s-w>", function () bdelete({force = true}) end, opts)

-- Folding
vim.keymap.set({"n", "v"}, "<space>", "za", opts)
vim.keymap.set({"n", "v"}, "<S-space>", "zA", opts)

-- Move text up and down
vim.keymap.set("n", "<A-S-j>", ":move .+1<cr>", opts)
vim.keymap.set("n", "<A-S-k>", ":move .-2<cr>", opts)
vim.keymap.set("v", "<A-S-j>", ":move '>+1<cr>gv", opts)
vim.keymap.set("v", "<A-S-k>", ":move '<-2<cr>gv", opts)

-- Indent
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste
vim.keymap.set("v", "p", 'P', opts)

-- Replace 's' with 'c'
vim.keymap.set("n", "s", "c", opts)
vim.keymap.set("n", "ss", "cc", opts)
vim.keymap.set("n", "S", "C", opts)
vim.keymap.set("n", "siw", "ciw", opts)
vim.keymap.set("n", "saw", "caw", opts)
vim.keymap.set("n", "siW", "ciW", opts)
vim.keymap.set("n", "saW", "caW", opts)

-- QuickOp
vim.keymap.set("n", "sw", "ciw", opts)
vim.keymap.set("n", "sW", "ciW", opts)
vim.keymap.set("n", "s'", "ci'", opts)
vim.keymap.set("n", 's"', 'ci"', opts)
vim.keymap.set("n", "s(", "ci(", opts)
vim.keymap.set("n", "s[", "ci[", opts)
vim.keymap.set("n", "s{", "ci{", opts)
vim.keymap.set("n", "s<", "ci<", opts)

local ops = { 'v', 'd', 'y', '~' }
for _, op in ipairs(ops) do
  vim.keymap.set("n", op .. "w", op .. "iw", opts)
  vim.keymap.set("n", op .. "W", op .. "iW", opts)
  vim.keymap.set("n", op .. "'", op .. "i'", opts)
  vim.keymap.set("n", op .. '"', op .. 'i"', opts)
  vim.keymap.set("n", op .. "(", op .. "i(", opts)
  vim.keymap.set("n", op .. "[", op .. "i[", opts)
  vim.keymap.set("n", op .. "{", op .. "i{", opts)
  vim.keymap.set("n", op .. "<", op .. "i<", opts)
end
