local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  cursorline = true,                       -- highlight the current line
  expandtab = true,                        -- convert tabs to spaces
  fileencoding = "utf-8",                  -- the encoding written to a file
  foldcolumn = "auto:9",
  foldenable = true,                       -- enabling folding
  foldexpr = "nvim_treesitter#foldexpr()", -- using nvim_treesitter expression
  foldlevelstart = 99,                     -- don't fold any text at the begining
  foldmethod = "expr",                     -- folding type
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  hidden = true,                          -- don't unload buffer when it is abandoned
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  iskeyword = '@,48-57,192-255',
  linebreak = true,                        -- companion to wrap, don't split words
  mouse = "a",                             -- allow the mouse to be used in neovim
  number = true,                           -- set numbered lines
  numberwidth = 2,                         -- set number column width to 2 {default 4}
  pumheight = 10,                          -- pop up menu height
  relativenumber = true,                  -- set relative numbered lines
  scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  shortmess = "at",
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  sidescrolloff = 8,                       -- minimal number of screen columns either side of cursor if wrap is `false`
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = true,                         -- creates a swapfile
  tabstop = 2,                             -- insert 2 spaces for a tab
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  tildeop = true,
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  wrap = true,                             -- display lines as one long line
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

