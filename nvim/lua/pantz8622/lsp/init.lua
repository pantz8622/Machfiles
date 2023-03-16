local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "pantz8622.lsp.mason"
require("pantz8622.lsp.handlers").setup()
require "pantz8622.lsp.null-ls"
