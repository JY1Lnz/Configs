return {
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
  -- colorschemes
  { "folke/tokyonight.nvim" },
  { "jy1lnz/onedark.nvim", version = "main" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("configs/catppuccin")
    end
  },
  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup()
  --   end
  -- },
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
    tag = "0.1.2",
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
  -- {
  --  "ahmedkhalf/project.nvim",
  --  config = function()
  --    require ("configs/project")
  --  end
  -- },
  {
    "MattesGroeger/vim-bookmarks",
    config = function()
    end,
  },
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    config = function()
    end
  },
  -- git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs/gitsigns")
    end
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("configs/diffview")
    end
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("configs/lazygit")
    end
  },
  -- dashboard
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("configs/dashboard")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
  },
  -- lsp
  {
    { "arkav/lualine-lsp-progress" }
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    -- event = "LspAttach",
    opts = {
    }
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
        "clangd",
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
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require("lsp/null-ls")
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
      require("lsp/lspsaga")
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
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   config = function ()
  --     require("indent_blankline").setup({
  --       char = '|',
  --       show_current_context = true,
  --     })
  --   end
  -- },
  {
    "shellRaining/hlchunk.nvim",
    event = "UIEnter",
    config = function()
      require("configs/indent")
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
    }
  },
  -- highlight
  -- {  -- cannot use
  --   "folke/todo-comments.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   -- config = function ()
  --   --   require("configs/todo-comments")
  --   -- end
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("configs/nvim-treesitter")
    end,
    -- dependencies = {
    --   "p00f/nvim-ts-rainbow"
    -- }
  },
  -- outline
  -- {
  --   "stevearc/aerial.nvim",
  --   opts = {},
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons"
  --   },
  --   config = function()
  --     require("configs/aerial")
  --   end
  -- },
  {
    "simrat39/symbols-outline.nvim",
    config = function ()
      require("configs/symbols-outline")
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
  --debug
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
    "ggandor/leap.nvim",
    config = function ()
      require("leap").add_default_mappings()
    end
  },
  -- {
  --   "phaazon/hop.nvim",
  --   branch = "v2",
  --   opts = {
  --
  --   },
  --   config = function()
  --     require("configs/hop");
  --   end
  -- },
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
  {
    "simeji/winresizer",
    config = function()
    end
  },
  -- markdown
  {
    "skanehira/preview-markdown.vim",
    dependencies = { "MichaelMure/mdr" },
    config = function()
      vim.g.preview_markdown_auto_update = 1
    end
  },
  -- translator
  {
    "voldikss/vim-translator",
    config = function()
      vim.g.translator_window_type = 'preview'
      vim.g.translator_default_engines = { 'google', 'bing' }
    end
  },
  -- log
  {
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
        virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
        -- virt_text_pos = 'eol',

        -- experimental features:
        all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      })
    end
  },
  -- tmux
  -- {
  --   "aserowy/tmux.nvim"
  -- },
  --
  -- {
  --   "tpope/vim-repeat",
  --   "tpope/vim-surround",
  -- }
}
