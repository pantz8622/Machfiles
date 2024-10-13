-- Appearance
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "󰌵" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config {
  virtual_text = false, -- disable virtual text
  signs = {
    active = signs, -- show signs
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = false,
    header = "",
    prefix = "",
  },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})

-- Global mappings.
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>h", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>qh", vim.diagnostic.setqflist, opts)
vim.keymap.set("n", "]h", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "[h", vim.diagnostic.goto_prev, opts)

local function fallback()
  print('No Language Server was Attached.')
end
vim.keymap.set('n', '<leader>k', fallback, opts)
vim.keymap.set('n', '<leader>s', fallback, opts)
vim.keymap.set('n', '<leader>r', fallback, opts)
vim.keymap.set({ 'n', 'v' }, '<leader>a', fallback, opts)
vim.keymap.set('n', '<leader>f', fallback, opts)
vim.keymap.set('n', 'qr', fallback, opts)
vim.keymap.set('n', 'qi', fallback, opts)
vim.keymap.set("n", "qc", fallback, opts)
vim.keymap.set("n", "qC", fallback, opts)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>s', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
    vim.keymap.set('n', 'qr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'qi', vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "qc", vim.lsp.buf.outgoing_calls, opts)
    vim.keymap.set("n", "qC", vim.lsp.buf.incoming_calls, opts)
  end,
})
