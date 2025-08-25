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
      -- ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      -- ["vim.lsp.util.stylize_markdown"] = true,
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
    enabled = false,
    filter = {
      ["not"] = { kind = { "echo" } }
    }
  },
  notify = {
    enabled = false,
  },
  views = {
    enabled = true,
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
    },
    {
      filter = {
        event = "notify",
        -- kind = "echomsg",
        find = "group",
      },
      opts = { skip = true, }
    },
  },
  cmdline = {
    enabled = true,         -- enables the Noice cmdline UI
    view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    opts = {}, -- global options for the cmdline. See section on views
    ---@type table<string, CmdlineFormat>
    format = {
      -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
      -- view: (default is cmdline view)
      -- opts: any options passed to the view
      -- icon_hl_group: optional hl_group for the icon
      -- title: set to anything or empty string to hide
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
      input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
      -- lua = false, -- to disable a format, set to `false`
    },
  },
})

-- local Manager = require("noice.message.manager")
--
-- vim.api.nvim_create_user_command('NoiceClear', function()
--   local messages = Manager.get({ has = true }, { history = true })
--   for _, msg in ipairs(messages) do
--     Manager.remove(msg)
--   end
-- end, { desc = 'Noice clear' })
