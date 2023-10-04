local configs = require "nvim-treesitter.configs"

configs.setup {
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,
	indent = {
    enable = true,
    disable = { "" },
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
