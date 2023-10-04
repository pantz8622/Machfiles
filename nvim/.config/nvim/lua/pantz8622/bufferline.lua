local bufferline = require "bufferline"
local icons = require 'nvim-web-devicons'

local function filter(buf_number, buf_numbers)
  -- filter out filetypes you don't want to see
  if vim.bo[buf_number].filetype ~= "qf" then
    return true
  end
end

-- fallback to bdelete if bbye is not installed
local buffer_delete = function (bufnr) vim.cmd('bdelete' .. ' ' .. bufnr) end
local has_bbye, bbye = pcall(require, 'vim-bbye')
if has_bbye then
  buffer_delete = function (bufnr) bbye.bdelete({bufnr = bufnr, force = false}) end
end

bufferline.setup {
  options = {
    mode = "buffers",
    numbers = "none",
    close_command = buffer_delete,
    right_mouse_command = false,
    left_mouse_command = "buffer %d",
    buffer_close_icon = '',
    modified_icon = '●',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    truncate_names = true,
    tab_size = 18,
    diagnostics = false,
    diagnostics_update_in_insert = false,
    diagnostics_indicator = nil,
    custom_filter = filter, -- NOTE: this will be called a lot so don't do any heavy processing here
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = false,
    show_duplicate_prefix = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    sort_by = 'insert_at_end',
    middle_mouse_command = nil,
    indicator = {
        icon = '▎',
        style = 'icon'
    },
    offsets = {
        {
            filetype = "NvimTree",
            text = "",
            separator = true,
            padding = 1,
        }
    },
    get_element_icon = function(buf)
      return icons.get_icon(buf.filetype, {default = false})
    end,
  }
}

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-Tab>", ":BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<C-S-Tab>", ":BufferLineCyclePrev<CR>", opts)
