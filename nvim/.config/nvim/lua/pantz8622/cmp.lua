local cmp = require('cmp')
local luasnip = require('luasnip')

require("luasnip.loaders.from_vscode").lazy_load()

local kind_icons = {
  Text = "󰦨",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰆧",
  Class = "󰌗",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰇽",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
}

local function move_to_next(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end

local function move_to_prev(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function jump_to_next(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

local function jump_to_prev(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({ nvim_lua = "[nvim]", nvim_lsp = "[lsp]", luasnip = "[snip]", buffer = "[buf]", path = "[path]" })[entry.source.name]
      return vim_item
    end,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<A-Space>"] = cmp.mapping(cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Replace }, { "i", "c" }),
    ["<Space>"] = cmp.mapping(cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Replace }, { "i", "c" }),
    ["<Enter>"] = cmp.mapping(cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Replace }, { "i", "c" }),
    ["<A-j>"] = cmp.mapping(move_to_next, {"i", "c"}),
    ["<A-k>"] = cmp.mapping(move_to_prev, {"i", "c"}),
    ["<Tab>"] = cmp.mapping(jump_to_next, {"i", "c"}),
    ["<A-Tab>"] = cmp.mapping(jump_to_prev, {"i", "c"}),
    ["<S-Tab>"] = cmp.mapping(jump_to_prev, {"i", "c"}),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lua" },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = "path" },
  }),
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
