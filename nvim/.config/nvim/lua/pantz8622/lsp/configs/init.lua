local lspconfig = require("lspconfig")

local clients = {
  'lua_ls',
  'pyright',
}

for _, client in ipairs(clients) do
  local exist, config = pcall(require, "pantz8622.lsp.configs." .. client)
  if exist then
    lspconfig[client].setup(config)
  else
    lspconfig[client].setup({ })
  end
end
