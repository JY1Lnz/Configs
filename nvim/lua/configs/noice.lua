-- 作者提供了一些routes方法，用来自定义的去操作一些设定
-- 具体看github页面下的解释
-- h: ui-message
-- routes = {
--   filter = {
--     event = "xxx",
--     kind = "xxx",
--     find = "xxx",
--   }
-- }

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
    enabled = true,
    filter = {
      ["not"] = { kind = { "echo" } }
    }
  },
  notify = {
    enabled = true,
  },
  views = {
    cmdline_popup = {
      position = {
        row = 2,
        col = "50%",
      }
    }
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true, },
    },
    {
      filter = {
        event = "msg_show",
        kind = "echomsg",
        find = "AutoSave",
      },
      opts = { skip = true, }
    },
    {
      filter = {
        event = "msg_show",
        kind = "echo",
        find = "fewer",
      },
      opts = { skip = true, }
    },
    {
      filter = {
        event = "msg_show",
        kind = "echomsg",
        find = "deprecated",
      },
      opts = { skip = true, }
    }
  },
  -- cmdline = {
  --   enabled = true,
  --   view = "cmdline_popup",
  -- },
})
