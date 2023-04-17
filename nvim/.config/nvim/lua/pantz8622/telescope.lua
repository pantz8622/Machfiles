local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local in_git_repo = require("pantz8622.utils").in_git_repo
local get_git_root = require("pantz8622.utils").get_git_root

local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local themes = require('telescope.themes')

local function find_files_from_project()
  local rg_opts = {'--hidden', '--no-ignore'}
  local ignore = {
    '**/.git',
  }

  local base = vim.fn.fnamemodify('.', ':p')
  if in_git_repo() then
    base = get_git_root()
  end

  local opts = themes.get_dropdown{previewer = false}
  opts.cwd = base
  opts.find_command = {'rg', '--files', unpack(rg_opts)}
  table.insert(opts.find_command, '--iglob')
  for _, i in ipairs(ignore) do
    table.insert(opts.find_command, '!'..i)
  end
  table.insert(opts.find_command, base)
  builtin.find_files(opts)
end

local function find_files_from_buffers()
  local rg_opts = {'--hidden', '--no-ignore'}
  local ignore = {
    '**/.git',
  }

  local base = vim.fn.fnamemodify('.', ':p')
  if in_git_repo() then
    base = get_git_root()
  end

  -- find buffers visible at bufferline
  local bufs = {}
  for _,e in ipairs(require('pantz8622.bufferline').get_elements().elements) do
    if vim.fn.isdirectory(e.path) ~= 1 then
      table.insert(bufs, e.path)
    end
  end

  local opts = themes.get_dropdown{previewer = false}
  opts.cwd = base
  opts.find_command = {'rg', '--files', unpack(rg_opts)}
  if #ignore > 0 or #bufs > 0 then
    table.insert(opts.find_command, '--iglob')
    for _, i in ipairs(ignore) do
      table.insert(opts.find_command, '!'..i)
    end
    for _, buf in ipairs(bufs) do
      table.insert(opts.find_command, buf)
    end
    builtin.find_files(opts)
  end
end

local function grep_files_from_project()
  local base = vim.fn.fnamemodify('.', ':p')
  if in_git_repo() then
    base = get_git_root()
  end

  local opts = {
    cwd = base,
    additional_args = {
      '--hidden',
      '--no-ignore',
      '--glob', '!**/.git',
    },
  }
  builtin.live_grep(opts)
end

local function grep_files_from_buffers()
  local base = vim.fn.fnamemodify('.', ':p')
  if in_git_repo() then
    base = get_git_root()
  end

  local opts = {
    cwd = base,
    grep_open_files = true,
    additional_args = {
      '--hidden',
      '--no-ignore',
      '--glob', '!**/.git',
    }
  }
  builtin.live_grep(opts)
end

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",

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

keymap("n", "<leader>gD", ":Telescope lsp_type_definitions<CR>", opts)
keymap("n", "<leader>gd", ":Telescope lsp_definitions<CR>", opts)
keymap("n", "<leader>gi", ":Telescope lsp_implementations<CR>", opts)

keymap("n", "<leader>fa", "<cmd>lua require('pantz8622.telescope').find_files_from_project()<cr>", opts)
keymap("n", "<leader>ga", "<cmd>lua require('pantz8622.telescope').grep_files_from_project()<cr>", opts)

keymap("n", "<leader>ff", "<cmd>lua require('pantz8622.telescope').find_files_from_buffers()<cr>", opts)
keymap("n", "<leader>gg", "<cmd>lua require('pantz8622.telescope').grep_files_from_buffers()<cr>", opts)

keymap("n", "<leader>gr", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>gc", ":Telescope lsp_outgoing_calls<CR>", opts)
keymap("n", "<leader>gC", ":Telescope lsp_incoming_calls<CR>", opts)

keymap("n", "<leader>fq", ":Telescope quickfix<CR>", opts)
keymap("n", "<leader>fd", ":lua require('telescope.builtin').diagnostics()<CR>", opts)

M = {}

M.find_files_from_project = find_files_from_project
M.find_files_from_buffers = find_files_from_buffers
M.grep_files_from_project = grep_files_from_project
M.grep_files_from_buffers = grep_files_from_buffers

return M
