local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<Tab>"] = actions.move_selection_worse,
        ["<S-Tab>"] = actions.move_selection_better,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<esc>"] = actions.close,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<CR>"] = actions.select_default,
        ["<C-Space>"] = actions.toggle_selection,
        ["<C-S-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-/>"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}

-- workaround for folding bug
vim.api.nvim_create_autocmd('BufRead', {
   callback = function()
      vim.api.nvim_create_autocmd('BufWinEnter', {
         once = true,
         command = 'normal! zx'
      })
   end
})

-- keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>D", ":Telescope lsp_type_definitions<CR>", opts)
keymap("n", "<leader>d", ":Telescope lsp_definitions<CR>", opts)
keymap("n", "<leader>i", ":Telescope lsp_implementations<CR>", opts)

keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)

keymap("n", "<leader>fr", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>fc", ":Telescope lsp_outgoing_calls<CR>", opts)
keymap("n", "<leader>fC", ":Telescope lsp_incoming_calls<CR>", opts)
keymap("n", "<leader>fq", ":Telescope quickfix<CR>", opts)
keymap("n", "<leader>fd", ":lua require('telescope.builtin').diagnostics()<CR>", opts)

keymap("n", "<leader>st", ":Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "<leader>ss", ":Telescope lsp_document_symbols<CR>", opts)
keymap("n", "<leader>sd", ":lua require('telescope.builtin').diagnostics({bufnr=0})<CR>", opts)


