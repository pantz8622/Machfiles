local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup {
  signs = {
    add          = { text = "▎" },
    change       = { text = "▎" },
    delete       = { text = "契" },
    topdelete    = { text = "契" },
    changedelete = { text = "▎" },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = { noremap = true, silent = true }
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>h', gs.preview_hunk)
    map('n', '<leader>b', function() gs.blame_line{full=false} end)
    map("n", "<leader>qh", gs.setqflist)

    -- Text object
    map("n", "<S-v>h", ":Gitsigns select_hunk<CR>")
    map("n", "sh", ":Gitsigns select_hunk<CR>c")
    local ops = { 'd', 'y', '~' }
    for _, op in ipairs(ops) do
      map("n", op .. "h", ":Gitsigns select_hunk<CR>" .. op)
    end
  end
}

-- Cowork with Comment.nvim
vim.api.nvim_set_keymap("n", "ch", ":Gitsigns select_hunk<CR>c", { noremap = false, silent = true })
