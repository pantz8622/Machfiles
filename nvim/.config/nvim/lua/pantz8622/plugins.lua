local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.loop.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',
  'folke/tokyonight.nvim',
  'akinsho/bufferline.nvim',
  'numToStr/Comment.nvim',
  'neovim/nvim-lspconfig',
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  'hrsh7th/nvim-cmp',
 'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
	'pantz8622/vim-bbye',
  'RRethy/vim-illuminate',
  'pantz8622/ctoggle',
  { "iamcco/markdown-preview.nvim", run = "cd app && npm install" },
  { 'nvim-telescope/telescope.nvim',
    requires = {{ 'nvim-lua/plenary.nvim' }}},
  "nvim-lua/plenary.nvim",
  { 'L3MON4D3/LuaSnip', run = 'make install_jsregexp' },
  'saadparwaiz1/cmp_luasnip',
  { 'nvim-treesitter/nvim-treesitter', run = function ()
    require('nvim-treesitter.install').update()
  end,
  },
  'lewis6991/gitsigns.nvim',
  'lukas-reineke/indent-blankline.nvim',
}
