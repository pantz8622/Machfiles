vim.cmd([[
  function! OpenMarkdownPreview(url)
    execute "silent ! chromium --new-window " . a:url
  endfunction
]])

local opts = {
  mkdp_browserfunc = 'OpenMarkdownPreview',
  mkdp_page_title = "'「${name}」'",
  mkdp_filetypes = {'markdown'},
}

for key, val in pairs(opts) do
  vim.g[key] = val
end

local keymap_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>p", "<cmd>MarkdownPreviewToggle<cr>", keymap_opts)
