local gitsigns = require('gitsigns')

gitsigns.setup {
  max_file_length = 40000,
  signs = {
    add          = { text = "▎" },
    change       = { text = "▎" },
    delete       = { text = "" },
    topdelete    = { text = "" },
    changedelete = { text = "▎" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or { }
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    local opts = { noremap = true, silent = true }

    -- Navigation
    map('n', ']g', function()
      if vim.wo.diff then return ']g' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[g', function()
      if vim.wo.diff then return '[g' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>g', gs.preview_hunk, opts)
    map('n', '<leader>b', function() gs.blame_line{full=false} end, opts)
    map("n", "<leader>qg", gs.setqflist, opts)

    -- Text object
    map("n", "vg", ":Gitsigns select_hunk<CR>")
    map("n", "sg", ":Gitsigns select_hunk<CR>c")
    local ops = { 'd', 'y', '~' }
    for _, op in ipairs(ops) do
      map("n", op .. "g", ":Gitsigns select_hunk<CR>" .. op)
    end
  end
}

