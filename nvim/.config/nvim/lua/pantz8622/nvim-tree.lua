local nvim_tree = require("nvim-tree")
nvim_tree.api = require("nvim-tree.api")

local function open()
  nvim_tree.api.node.open.edit()
  nvim_tree.api.tree.focus()
end

local function open_quit()
  nvim_tree.api.node.open.edit()
  local node = nvim_tree.api.tree.get_node_under_cursor()
  if node.nodes == nil and node.name ~= '..' then -- quit only if it's a file
    nvim_tree.api.tree.close()
  end
end

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  -- nvim_tree.api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'w',             nvim_tree.api.tree.collapse_all,                 opts('Collapse'))
  vim.keymap.set('n', 'e',             nvim_tree.api.tree.expand_all,                   opts('Expand All'))
  vim.keymap.set('n', 'K',             nvim_tree.api.node.show_info_popup,              opts('Info'))
  vim.keymap.set('n', 'y',             nvim_tree.api.fs.copy.filename,                  opts('Copy Name'))
  vim.keymap.set('n', '<C-c>',         nvim_tree.api.fs.copy.node,                      opts('Copy'))
  vim.keymap.set('n', '<C-x>',         nvim_tree.api.fs.cut,                            opts('Cut'))
  vim.keymap.set('n', '<C-v>',         nvim_tree.api.fs.paste,                          opts('Paste'))
  vim.keymap.set('n', '<C-f>',         nvim_tree.api.live_filter.start,                 opts('Filter'))
  vim.keymap.set('n', '<Esc>',         nvim_tree.api.live_filter.clear,                 opts('Clean Filter'))
  vim.keymap.set('n', 'd',             nvim_tree.api.fs.trash,                          opts('Trash'))
  vim.keymap.set('n', 'n',             nvim_tree.api.fs.create,                         opts('Create'))
  vim.keymap.set('n', 'r',             nvim_tree.api.fs.rename,                         opts('Rename'))
  vim.keymap.set('n', '<CR>',          open_quit,                                       opts('open & quit'))
  vim.keymap.set('n', '<S-CR>',        nvim_tree.api.node.navigate.parent,              opts('Parent Directory'))
  vim.keymap.set('n', '<Space>',       open,                                            opts('open'))
  vim.keymap.set('n', '<2-LeftMouse>', open,                                            opts('open'))
  vim.keymap.set('n', 'h',             nvim_tree.api.tree.toggle_help,                  opts('Help'))
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

nvim_tree.setup {
  hijack_cursor = true,
  on_attach = on_attach,
  renderer = {
    root_folder_label = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "",
          untracked = "◌",
          deleted = "",
          ignored = "",
        },
      },
    },
  },
  git = {
    enable = false,
  },
  diagnostics = {
    enable = true,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR
    },
    show_on_dirs = false,
    icons = {
      hint = "󰌵",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
    side = "left",
  },
}

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", opts)
