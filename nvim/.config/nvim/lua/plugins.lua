require("lazy").setup({
  -- 快捷键提示
  require("plugins.which-key"),
  -- 侧边文件栏
  require("plugins.nvim-tree"),
  -- 上方缓冲区栏
  require("plugins.bufferline"),
  -- 下方状态栏
  require("plugins.lualine"),
  -- lsp下载
  require("plugins.mason"),
  -- 快速移动
  require("plugins.flash"),
  -- 检索
  require("plugins.fzf-lua"),
  -- lsp
  require("plugins.lspconfig"),
  -- 补全
  require("plugins.blink"),
  -- 高亮
  require("plugins.treesitter"),
  -- 配色
  require("plugins.colorscheme"),
  -- 符号大纲
  require("plugins.aerial"),
  -- quickfix 增强
  require("plugins.bqf"),
  -- 终端
  require("plugins.toggleterm"),
  -- session manager
  require("plugins.persistence"),
  -- pairs
  require("plugins.pairs"),
  -- lsp saga
  require("plugins.lsp-saga"),
  -- hover
  require("plugins.hover"),
  -- git
  require("plugins.gitsigns"),
  -- utils
  require("plugins.snacks"),
  -- neogit
  require("plugins.neogit"),
  -- trouble
  require("plugins.trouble"),



  -- Simple
  { "jy1lnz/onedark.nvim" },
  { "djoshea/vim-autoread" },
  { "arkav/lualine-lsp-progress" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { 'skywind3000/asyncrun.vim' }
})

tmp = {
  -- copy
  {
    "ojroques/vim-oscyank",
    version = "main",
  },
  {
    "jy1lnz/onedark.nvim",
    version = "main",
    config = function()
      require("onedark").setup({
        -- transparent = true,
      })
    end
  },
  -- dap
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("lsp/dap")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      -- require("lsp/dap-ui")
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,                     -- enable this plugin (the default)
        enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true,            -- show stop reason when stopped for exceptions
        commented = false,                  -- prefix virtual text with comment string
        only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
        all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
        clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
        display_callback = function(variable, buf, stackframe, node, options)
          if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value
          else
            return variable.name .. ' = ' .. variable.value
          end
        end,
        -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
        -- virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
        virt_text_pos = 'inline',
        -- virt_text_pos = 'eol',

        -- experimental features:
        all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      })
    end
  },
  -- -- vim-surround
  -- -- ds "   => delete "
  -- -- cs " ' => change " to '
  -- -- ys w ' => add '
  -- -- https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94

  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require("dap-python").setup("python")
    end
  },
}
