local telescope = require('telescope')

local actions = require "telescope.actions"
local state = require "telescope.actions.state"
local builtin = require "telescope.builtin"
local themes = require('telescope.themes')

local root = vim.fn.fnamemodify('.', ':p')
local cwd = vim.fn.fnamemodify('.', ':p')

local function find_files_from(base, opts)
  if opts == nil then opts = { } end
  if opts.rg_opts == nil then opts.rg_opts = {'--hidden', '--no-ignore'} end
  if opts.include == nil then opts.include = { } end
  if opts.ignore == nil then opts.ignore = {
    '**/.git',
  } end
  cwd = base

  local ff_opts = themes.get_dropdown{previewer = false}
  ff_opts.cwd = base
  ff_opts.find_command = {'rg', '--files', unpack(opts.rg_opts)}
  table.insert(ff_opts.find_command, '--iglob')
  for _, i in ipairs(opts.ignore) do
    table.insert(ff_opts.find_command, '!'..i)
  end
  for _, i in ipairs(opts.include) do
    table.insert(ff_opts.find_command, i)
  end
  table.insert(ff_opts.find_command, base)
  builtin.find_files(ff_opts)
end

local function find_files_from_project()
  find_files_from(root)
end

local function find_files_from_current()
  find_files_from(vim.fn.fnamemodify('.', ':p'))
end

local function find_files_from_buffers()
  local bufs = {}
  for _,e in ipairs(require('bufferline').get_elements().elements) do
    if vim.fn.isdirectory(e.path) ~= 1 then
      table.insert(bufs, e.path)
    end
  end

  find_files_from(root, { ignore = {'*'}, include = bufs})
end

local function grep_from(base, opts)
  if opts == nil then opts = { } end
  if opts.use_regex == nil then opts.use_regex = false end
  if opts.grep_open_files == nil then opts.grep_open_files = false end
  if opts.search_dirs == nil then opts.search_dirs = { } end
  if opts.additional_args == nil then opts.additional_args = {
    '--hidden',
    '--no-ignore',
    '--glob', '!**/.git',
  } end

  opts.cwd = base
  if opts.search == nil then
    builtin.live_grep(opts)
  else
    builtin.grep_string(opts)
  end
end

local function get_selected(opts)
  local picker = state.get_current_picker(opts)
  local selected = { }
  if next(picker:get_multi_selection()) ~= nil then
    for _, entry in ipairs(picker:get_multi_selection()) do
      table.insert(selected, entry[1])
    end
  end
  return selected
end

actions.grep_selected = function(opts)
  local selected = get_selected(opts)
  pcall(grep_from, cwd, { search_dirs = selected })
end

actions.fuzzy_selected = function(opts)
  local selected = get_selected(opts)
  pcall(grep_from, cwd, { search_dirs = selected, search = '.*', use_regex = true })
end

actions.edit_selected = function (opts)
  local selected = get_selected(opts)
  if next(selected) == nil then
    actions.file_edit(opts)
  else
    for _, file in ipairs(selected) do
      vim.cmd('silent edit! ' .. file)
    end
  end
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
        ["<A-Tab>"] = actions.move_selection_better,

        ["<A-j>"] = actions.move_selection_next,
        ["<A-k>"] = actions.move_selection_previous,

        ["<esc>"] = actions.close,

        ["<A-u>"] = actions.preview_scrolling_up,
        ["<A-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<CR>"] = actions.edit_selected,
        ["<A-Space>"] = actions.toggle_selection,
        ["<C-a>"] = actions.select_all,
        ["<C-g>"] = actions.grep_selected,
        ["<C-f>"] = actions.fuzzy_selected,
        ["<C-S-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
}

-- keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "fd", builtin.lsp_definitions, opts)
vim.keymap.set("n", "fD", builtin.lsp_type_definitions, opts)
vim.keymap.set("n", "fi", builtin.lsp_implementations, opts)
vim.keymap.set("n", "fr", builtin.lsp_references, opts)
vim.keymap.set("n", "fc", builtin.lsp_outgoing_calls, opts)
vim.keymap.set("n", "fC", builtin.lsp_incoming_calls, opts)
vim.keymap.set("n", "fq", builtin.quickfix, opts)
vim.keymap.set("n", "fh", builtin.diagnostics, opts)

vim.keymap.set("n", "ff", find_files_from_project, opts)
vim.keymap.set("n", "f.", find_files_from_current, opts)
vim.keymap.set("n", "fb", find_files_from_buffers, opts)

vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, opts)

-- workaround for folding bug
vim.api.nvim_create_autocmd('BufRead', {
   callback = function()
      vim.api.nvim_create_autocmd('BufWinEnter', {
         once = true,
         command = 'normal! zx'
      })
   end
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    root = vim.lsp.buf.list_workspace_folders()[1]
  end,
})
