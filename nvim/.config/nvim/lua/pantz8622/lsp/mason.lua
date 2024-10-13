local mason = require("mason")
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
  }
})

mason_lspconfig.setup_handlers({
  function(client)
    local exist, config = pcall(require, "pantz8622.lsp.configs." .. client)
    if exist then
      lspconfig[client].setup(config)
    else
      lspconfig[client].setup({ })
    end
  end
})
