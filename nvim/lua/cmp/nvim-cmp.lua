local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    -- { name = "path" },
    -- { name = "luasnip" },
    -- { name = "cmp_tabnine" },
    -- { name = "nvim_lua" },
    -- { name = "buffer" },
    -- { name = "spell" },
    -- { name = "calc" },
    -- { name = "emoji" },
    -- { name = "treesitter" },
    -- { name = "crates" },
  },
  mapping = {
    ["<C-j>"] = cmp.mapping.select_next_ite(),
  }
})
