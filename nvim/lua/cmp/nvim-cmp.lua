local cmp = require("cmp")

cmp_config = {
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  completion = {
    ---@usage The minimum length of a word to complete on.
    keyword_length = 2,
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    max_width = 40,
    kind_icons = {
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = "󰊕 ",
      Interface = " ",
      Keyword = " ",
      Method = " ",
      Module = "󰕳 ",
      Operator = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      Struct = " ",
      Text = "󰦨 ",
      TypeParameter = " ",
      Unit = " ",
      Value = "󱁦 ",
      Variable = " ",
    },
    source_names = {
      nvim_lsp = "(LSP)",
      -- treesitter = "(TS)",
      emoji = "(Emoji)",
      path = "(Path)",
      calc = "(Calc)",
      cmp_tabnine = "(Tabnine)",
      vsnip = "(Snippet)",
      luasnip = "(Snippet)",
      buffer = "(Buffer)",
      spell = "(Spell)",
    },
    flag = {
      debounce_text_changes = 150,
    },
    duplicates = {
      buffer = 1,
      path = 1,
      nvim_lsp = 0,
      luasnip = 1,
    },
    duplicates_default = 0,
    format = function(entry, vim_item)
      local max_width = cmp_config.formatting.max_width
      if max_width ~= 0 and #vim_item.abbr > max_width then
        vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
      end
      vim_item.kind = cmp_config.formatting.kind_icons[vim_item.kind]
      vim_item.menu = cmp_config.formatting.source_names[entry.source.name]
      vim_item.dup = cmp_config.formatting.duplicates[entry.source.name]
          or cmp_config.formatting.duplicates_default
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    -- completion = { max_height = 10, max_width = 10 },
    documentation = cmp.config.window.bordered(),
    -- documentation = { max_height = 5, max_width = 5 },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    -- { name = "cmp_tabnine" },
    { name = "nvim_lua" },
    { name = "buffer" },
    -- { name = "spell" },
    -- { name = "calc" },
    -- { name = "emoji" },
    -- { name = "treesitter" },
    -- { name = "crates" },
  },
  mapping = cmp.mapping.preset.insert {
    ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
    -- ["<C-.>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
    -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
    ["<A-,>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close()
    }),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<Tab>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace
    }),
 }
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.insert {
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), {"n", "c"}),
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"n", "c"}),
  },
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline('?', {
  mapping = cmp.mapping.preset.insert {
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), {"n", "c"}),
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"n", "c"}),
  },
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.insert {
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), {"n", "c"}),
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"n", "c"}),
  },
  sources = cmp.config.sources({
    { name = 'cmdline' }
  }, {
    { name = 'path' }
  })
})

cmp.setup(cmp_config)


