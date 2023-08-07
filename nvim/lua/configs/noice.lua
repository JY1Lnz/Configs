require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    signature = {
      enabled = false,
    },
  },
  preset = {
    bottom_search = true,
    command_palete = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
  messages = {
    -- enabled = false,
    -- filter = {
    --   ["not"] = { kind = { "echo" } }
    -- }
  },
  notify = {
    enabled = false,
  },
  views = {
    cmdline_popup = {
      position = {
        row = 2,
        col = "50%",
      }
    }
  }
  -- cmdline = {
  --   enabled = true,
  --   view = "cmdline_popup",
  -- },
})

