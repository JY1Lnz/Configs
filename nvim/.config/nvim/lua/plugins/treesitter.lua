return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    'windwp/nvim-ts-autotag',
  },
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    -- Luckily, the only things that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  build = ":TSUpdate",
  event = "VeryLazy",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>",      desc = "Decrement Selection", mode = "x" },
  },
  opts_extend = { "ensure_installed" },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["as"] = { query = "@scope", query_group = "locals" },
        ["az"] = { query = "@fold", query_group = "folds" },
        -- ["ai"] = "@call.outer",
        -- ["ii"] = "@call.inner",
        -- ["ad"] = "@conditional.outer",
        -- ["id"] = "@conditional.inner",
        -- ["ae"] = "@loop.outer",
        -- ["ie"] = "@loop.inner",
        -- ["ap"] = "@parameter.outer",
        -- ["ip"] = "@parameter.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["at"] = "@comment.outer",
        ["it"] = "@comment.inner",
        -- ["ar"] = "@return.outer",
        -- ["ir"] = "@return.inner",
        -- ["al"] = "@statement.outer",
        -- ["il"] = "@statement.inner",
        -- ["an"] = "@number.outer",
        -- ["in"] = "@number.inner",
        -- ["ah"] = "@assignment.outer",
        -- ["ih"] = "@assignment.inner",
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v',   -- charwise
        ['@function.outer'] = 'V',    -- linewise
        ['@statement.outer'] = 'V',   -- linewise
        ['@assignment.outer'] = 'V',  -- linewise
        ['@block.outer'] = 'V',       -- linewise
        ['@loop.outer'] = 'V',        -- linewise
        ['@conditional.outer'] = 'V', -- linewise
        ['@class.outer'] = 'V',       -- linewise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = false,

    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "+",
        node_incremental = "+",
        node_decremental = "-",
        -- scope_incremental = false,
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner", ["]n"] = "@number.*", },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner", ["[n"] = "@number.*", },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
      },
    },
  },
  ---@param opts TSConfig
  config = function(_, opts)
    -- if type(opts.ensure_installed) == "table" then
    --   opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
    -- end
    require("nvim-treesitter.configs").setup(opts)
  end,

}
