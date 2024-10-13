local nvim_tree = require("nvim-tree")
nvim_tree.api = require("nvim-tree.api")

-- Navigation --

local navigate_history = {}

local function navigate_up()
  local node = nvim_tree.api.tree.get_node_under_cursor()
  if node.name ~= ".." then
    table.insert(navigate_history, vim.api.nvim_win_get_cursor(0)[1])
    nvim_tree.api.node.navigate.parent()
  end
end

local function navigate_down()
  if #navigate_history ~= 0 then
    local lnr = table.remove(navigate_history, #navigate_history)
    vim.cmd(string.format("norm! %dG", lnr))
  end
end

local function navigate_next()
  navigate_history = {}
  vim.cmd("norm! j")
end

local function navigate_prev()
  navigate_history = {}
  vim.cmd("norm! k")
end

local function navigate_sibling_next()
  navigate_history = {}
  nvim_tree.api.node.navigate.sibling.next()
end

local function navigate_sibling_prev()
  navigate_history = {}
  nvim_tree.api.node.navigate.sibling.prev()
end

-- Root Navigation -- 

local history = {}

local function edit_goto()
  local node = nvim_tree.api.tree.get_node_under_cursor()
  if node.nodes == nil and node.name ~= ".." then -- open and quit if it's a file
    nvim_tree.api.node.open.edit()
  else
    table.insert(history, vim.fn.getcwd())
    nvim_tree.api.tree.change_root_to_node()
  end
end

local function backto_prev()
  if #history ~= 0 then
    nvim_tree.api.tree.change_root(table.remove(history, #history))
  end
end

local function open()
  local node = nvim_tree.api.tree.get_node_under_cursor()
  if node.name ~= ".." then
    nvim_tree.api.node.open.edit()
    nvim_tree.api.tree.focus()
  end
end

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  -- nvim_tree.api.config.mappings.default_on_attach(bufnr)

  -- navigate
  vim.keymap.set('n', '<CR>',          edit_goto,                                       opts('Edit & Goto'))
  vim.keymap.set('n', '<S-CR>',        backto_prev,                                     opts('Goto Previous'))
  vim.keymap.set('n', 'h',             navigate_up,                                     opts('Up'))
  vim.keymap.set('n', 'l',             navigate_down,                                   opts('Down'))
  vim.keymap.set('n', 'j',             navigate_next,                                   opts('Next'))
  vim.keymap.set('n', 'k',             navigate_prev,                                   opts('Prev'))
  vim.keymap.set('n', '<S-j>',         navigate_sibling_next,                           opts('Next Sibling'))
  vim.keymap.set('n', '<S-k>',         navigate_sibling_prev,                           opts('Prev Sibling'))
  vim.keymap.set('n', 'w',             nvim_tree.api.tree.collapse_all,                 opts('Collapse'))
  vim.keymap.set('n', 'e',             nvim_tree.api.tree.expand_all,                   opts('Expand All'))

  -- file edit
  vim.keymap.set('n', 'n',             nvim_tree.api.fs.create,                         opts('Create'))
  vim.keymap.set('n', 'd',             nvim_tree.api.fs.trash,                          opts('Trash'))
  vim.keymap.set('n', 'r',             nvim_tree.api.fs.rename,                         opts('Rename'))
  vim.keymap.set('n', '<C-c>',         nvim_tree.api.fs.copy.node,                      opts('Copy'))
  vim.keymap.set('n', '<C-x>',         nvim_tree.api.fs.cut,                            opts('Cut'))
  vim.keymap.set('n', '<C-v>',         nvim_tree.api.fs.paste,                          opts('Paste'))

  -- others
  vim.keymap.set('n', '<Space>',       open,                                            opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>', open,                                            opts('Open'))
  vim.keymap.set('n', 'i',             nvim_tree.api.node.show_info_popup,              opts('Info'))
  vim.keymap.set('n', 'y',             nvim_tree.api.fs.copy.filename,                  opts('Copy Name'))
  vim.keymap.set('n', '/',             nvim_tree.api.live_filter.start,                 opts('Filter'))
  vim.keymap.set('n', '<Esc>',         nvim_tree.api.live_filter.clear,                 opts('Clean Filter'))
  vim.keymap.set('n', '?',             nvim_tree.api.tree.toggle_help,                  opts('Help'))
end

-- disable netrw
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
          untracked = "",
          deleted = "",
          ignored = "",
        },
      },
      git_placement = "signcolumn",
    },
  },
  git = {
    enable = true,
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
    signcolumn = "yes",
  },
}

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", opts)
