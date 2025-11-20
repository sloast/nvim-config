-- [nfnl] fnl/config/completion.fnl
local cmp = require("cmp")
local function _1_(args)
  return require("luasnip").lsp_expand(args.body)
end
return cmp.setup({snippet = {expand = _1_}, mapping = cmp.mapping.preset.insert({["<C-b>"] = cmp.mapping.scroll_docs(-4), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-Space>"] = cmp.mapping.complete(), ["<Tab>"] = cmp.mapping.confirm({select = true}), ["<CR>"] = cmp.mapping.confirm({select = false}), ["<Up>"] = cmp.mapping.select_prev_item(), ["<Down>"] = cmp.mapping.select_next_item()}), sources = {{name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"}, {name = "path"}}})
