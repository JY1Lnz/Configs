return {
  -- copy
  {
    "ojroques/vim-oscyank",
    version = "main",
  },
  -- keyboard
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
      require("configs/which-key")
    end
  },
  {
    "jy1lnz/onedark.nvim",
    version = "main",
    config = function ()
      require("onedark").setup({
        -- transparent = true,
      })
    end
  },
  -- sidebar
  {
    "nvim-tree/nvim-tree.lua",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("configs/nvim-tree")
    end
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("configs/bufferline")
    end
  },
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("configs/lualine")
    end
  },
  -- nvim session manager
  {
    "Shatur/neovim-session-manager",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("configs/neovim-session")
    end,
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      require("configs/telescope")
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  },
  -- bookmarks
  {
    'tomasky/bookmarks.nvim',
    -- after = "telescope.nvim",
    config = function()
      require('bookmarks').setup()
    end
  },
  -- git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs/gitsigns")
    end
  },
  -- -- VCS tool invalid
  -- -- {
  -- --   "sindrets/diffview.nvim",
  -- --   config = function()
  -- --     require("configs/diffview")
  -- --   end
  -- -- },
  -- {
  --   "kdheepak/lazygit.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim"
  --   },
  --   config = function()
  --     require("configs/lazygit")
  --   end
  -- },
  -- lsp
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function()
      require("lsp-inlayhints").setup({})
    end
  },
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup {
        init = function()
          -- Require providers
          require("hover.providers.lsp")
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          -- require('hover.providers.jira')
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = nil
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = true,
        title = true
      }
    end,
  },
  {
    "arkav/lualine-lsp-progress",
    event = "VeryLazy",
  },
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonInstallAll",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    opts = {
      ensure_installed = {
        "cmake-language-server",
        -- "clangd",
        "clang-format",
        "codelldb",
        "lua-language-server",
        "pyright",
      }
    },
    config = function(_, opts)
      require("lsp/mason")
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp/nvim-lspconfig")
    end
  },
  {
    event = "VeryLazy",
    "ray-x/lsp_signature.nvim",
    config = function()
      -- require("lsp/lsp-signature")
    end
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    }
  },
  -- cmp
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("cmp/nvim-cmp")
    end,
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lua" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {},
    config = function ()
      require("configs/blankline")
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("configs/nvim-treesitter")
    end,
    dependencies = {
      "p00f/nvim-ts-rainbow"
    }
  },
  -- outline
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("configs/aerial")
    end
  },
  -- auto save&load
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enable = true,
        -- execution_message = "",
        event = { "InsertLeave", "TextChanged" },
        conditions = {
          exists = true,
          filename_is_not = { "plugins.lua" },
          filetype_is_not = {},
          modifiable = true,
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135,
      })
    end
  },
  { "djoshea/vim-autoread" },
  -- --debug
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      require("configs/trouble")
    end
  },
  -- comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("configs/comments")
    end
  },
  -- move
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<C-s>", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
    },
  },
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      })
    end
  },
  -- terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("configs/toggleterm")
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
    "tpope/vim-repeat",
  },
  -- Example
  -- local function()
  -- end
  -- vim.keymap.set("n", "DotRepeat${NAME})", action, { silent = true })
  -- vim.keymap.set("n", "Key", function()
  --   action
  --   vim.fn["repeat#set"]("DotRepeat${NAME}", vim.v.count)
  --   
  -- end)
  {
    "tpope/vim-surround",
  },
  {
    "kevinhwang91/nvim-bqf",
    config = function()
      require('bqf').setup({
        auto_enable = true,
        auto_resize_height = true, -- highly recommended enable
        preview = {
            win_height = 12,
            win_vheight = 12,
            delay_syntax = 80,
            border = {'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
            show_title = false,
            should_preview_cb = function(bufnr, qwinid)
                local ret = true
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                local fsize = vim.fn.getfsize(bufname)
                if fsize > 100 * 1024 then
                    -- skip file size greater than 100k
                    ret = false
                elseif bufname:match('^fugitive://') then
                    -- skip fugitive buffer
                    ret = false
                end
                return ret
            end
        },
        -- make `drop` and `tab drop` to become preferred
        func_map = {
            drop = 'o',
            openc = 'O',
            split = '<C-s>',
            tabdrop = '<C-t>',
            -- set to empty string to disable
            tabc = '',
            ptogglemode = 'z,',
        },
        filter = {
            fzf = {
                action_for = {['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop'},
                extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
            }
        }
    })
    end
  },
  {
    'mfussenegger/nvim-dap-python',
    config = function ()
      require("dap-python").setup("python")
    end
  }
}
