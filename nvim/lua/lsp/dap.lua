local dap = require("dap")
local dapui = require("dapui")

require("dapui").setup({
  icons = { expanded = "", collapsed = "", current_frame = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
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
        "repl",
        -- { id = "repl", size = 0.75 },
        -- { id = "scopes", size = 0.3 },
        -- { id = "watches", size = 0.25 },
        -- { id = "stacks", size = 0.25 },
        -- { id = "breakpoints", size = 0.15 },
      },
      size = 30, -- 40 columns
      position = "left",
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
    enabled = true,
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


-- local dap_breakpoint = {
--     error = {
--       text = "🛑",
--       texthl = "DapBreakpoint",
--       linehl = "DapBreakpoint",
--       numhl = "DapBreakpoint",
--     },
--     condition = {
--         text = '',
--         texthl = 'DapBreakpoint',
--         linehl = 'DapBreakpoint',
--         numhl = 'DapBreakpoint',
--     },
--     rejected = {
--       text = "",
--       texthl = "DapBreakpoint",
--       linehl = "DapBreakpoint",
--       numhl = "DapBreakpoint",
--     },
--     logpoint = {
--         text = '',
--         texthl = 'DapLogPoint',
--         linehl = 'DapLogPoint',
--         numhl = 'DapLogPoint',
--     },
--     stopped = {
--         text = '',
--         texthl = 'DapStopped',
--         linehl = 'DapStopped',
--         numhl = 'DapStopped',
--     },
-- }
-- vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
-- vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
-- vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
-- vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
-- vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)

-- local dap_breakpoint_color = {
--     breakpoint = {
--         ctermbg=0,
--         fg='#993939',
--         bg='#31353f',
--     },
--     logpoing = {
--         ctermbg=0,
--         fg='#61afef',
--         bg='#31353f',
--     },
--     stopped = {
--         ctermbg=0,
--         fg='#98c379',
--         bg='#31353f'
--     },
-- }

-- vim.api.nvim_set_hl(0, 'DapBreakpoint', dap_breakpoint_color.breakpoint)
-- vim.api.nvim_set_hl(0, 'DapLogPoint', dap_breakpoint_color.logpoing)
-- vim.api.nvim_set_hl(0, 'DapStopped', dap_breakpoint_color.stopped)


dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13123,
  executable = {
    command = '/home/jinyulin/.local/share/nvim/mason/bin/codelldb',
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
  vim.api.nvim_command("NvimTreeClose")
  dapui.open({})
  vim.api.nvim_command("DapVirtualTextEnable")
end

local debug_close = function ()
  dap.repl.close()
  dapui.close({})
  vim.api.nvim_command("DapVirtualTextDisable")
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

require("dap.ext.vscode").load_launchjs(vim.fn.getcwd() .. "/.vscode/launch.json", {
  codelldb = { 'h', 'cpp' },
  debugpy = { 'py', 'python' }
})

