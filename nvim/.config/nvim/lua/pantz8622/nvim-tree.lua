local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local nvim_tree_api = require("nvim-tree.api")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup {
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
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
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
    side = "left",
    mappings = {
      list = {
        { key = { "<CR>", "e", "<2-LeftMouse>" },                              action = "comfirm", action_cb = function ()
          nvim_tree_api.node.open.edit()
          nvim_tree_api.tree.close()
        end },
        { key = "<Space>", action = "send_to_buffer", action_cb = function ()
          nvim_tree_api.node.open.edit()
          nvim_tree_api.tree.focus()
        end },
        { key = "<Tab>",                             action = "preview" },
        { key = "r",                                 action = "refresh" },
        { key = "a",                                 action = "create" },
        { key = "d",                                 action = "remove" },
        { key = "R",                                 action = "rename" },
        { key = "x",                                 action = "cut" },
        { key = "c",                                 action = "copy" },
        { key = "p",                                 action = "paste" },
        { key = "y",                                 action = "copy_name" },
        { key = "Y",                                 action = "copy_path" },
        { key = "-",                                 action = "dir_up" },
        { key = "o",                                 action = "system_open" },
        { key = "q",                                 action = "close" },
        { key = "W",                                 action = "collapse_all" },
        { key = "E",                                 action = "expand_all" },
        { key = "K",                                 action = "toggle_file_info" },
      },
    },
  },
}

-- keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>tt", ":NvimTreeToggle<CR>", opts)

