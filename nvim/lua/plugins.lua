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
  {"folke/tokyonight.nvim"},
  {"ful1e5/onedark.nvim"},

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
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
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
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
}
