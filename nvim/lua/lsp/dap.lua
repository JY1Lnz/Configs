local dap = require("dap")
local dapui = require("dapui")

require("dapui").setup({
  icons = { expanded = "", collapsed = "", current_frame = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = "o",
    open = "<CR>",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    stacks = {
      open = "<CR>",
      expand = "o",
    },
    eval = {
      open = "<CR>",
      expand = "o",
    }
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = true,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        -- "repl",
        { id = "scopes", size = 0.4 },
        { id = "watches", size = 0.3 },
        -- { id = "repl", size = 0.75 },
        { id = "stacks", size = 0.3 },
        -- { id = "breakpoints", size = 0.15 },
      },
      size = 30, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        -- { id = "repl", size = 0.75 },
      },
      size = 30,
      position = "right",
    },
    {
      elements = {
        -- "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = false,
    -- Display controls in this element
    element = "console",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

dap.adapters.lldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13123,
  executable = {
    command = '/Users/jyl/.vscode/extensions/vadimcn.vscode-lldb-1.11.1/adapter/codelldb',
    args = { "--port", "13123" },
  },
}

dap.adapters.debugpy = {
  type = 'executable',
  command = 'python',
  args = { "-m", "debugpy.adapter" },
  options = {
    source_filetype = 'python',
  }
}

-- dap.configurations.python = {
--   {
--     type = "debugpy",
--     request = "launch",
--     name = "debug py",
--     program = "${file}"
--   }
-- }

-- dap.configurations.cpp = {
--   {
--     name = "Launch file",
--     type = "codelldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--   },
-- }

local debug_open = function ()
  require('custom/state').set_debug(true)
  vim.api.nvim_command("NvimTreeClose")
  dapui.open({})
  -- vim.api.nvim_command("DapVirtualTextEnable")
  vim.api.nvim_command("DapVirtualTextDisable")
end

local debug_close = function ()
  dap.repl.close()
  dapui.close({})
  require('custom/state').set_debug(false)
  -- vim.api.nvim_command("DapVirtualTextDisable")
end

dap.listeners.after.event_initialized["dapui_config"] = function ()
  debug_open()
end

dap.listeners.before.event_terminated["dapui_config"] = function ()
  debug_close()
end

dap.listeners.before.event_exited["dapui_config"] = function ()
  debug_close()
end

dap.listeners.before.disconnect["dapui_config"] = function ()
  debug_close()
end

if require('util').fileExists(vim.fn.getcwd() .. "/.vscode/launch.json") then
  require("dap.ext.vscode").load_launchjs(vim.fn.getcwd() .. "/.vscode/launch.json", {
    codelldb = { 'h', 'cpp', 'c' },
    debugpy = { 'py', 'python' }
  })
end

_G.store_breakpoints = require('util').store_breakpoints
_G.load_breakpoints = require('util').load_breakpoints
