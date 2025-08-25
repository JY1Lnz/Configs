local nt = require("nvim-treesitter.configs")
nt.setup({
  ensure_installed = {
    "json", "html", "css", "vim", "lua", "javascript", "typescript", "c", "cpp", "python", "lua"
  },
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
    disable = function(lang, buf)
      local max_filesize = 4 * 1024 * 1024
      local ok, status = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and status and status.size > max_filesize then
        return true
      end
    end
  },
  -- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  indent = {
    enable = false,
  },
  rainbow = {
    enable = false,
    extenden_mode = true,
    max_file_liens = nil,
  },
  fold = {
    enable = true,
  },
  textobjects = {
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
        ["ai"] = "@call.outer",
        ["ii"] = "@call.inner",
        ["ad"] = "@conditional.outer",
        ["id"] = "@conditional.inner",
        ["ae"] = "@loop.outer",
        ["ie"] = "@loop.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["at"] = "@comment.outer",
        ["it"] = "@comment.inner",
        ["ar"] = "@return.outer",
        ["ir"] = "@return.inner",
        ["al"] = "@statement.outer",
        ["il"] = "@statement.inner",
        ["an"] = "@number.outer",
        ["in"] = "@number.inner",
        ["ah"] = "@assignment.outer",
        ["ih"] = "@assignment.inner",
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v',            -- charwise
        ['@function.outer'] = 'V',             -- linewise
        ['@statement.outer'] = 'V',            -- linewise
        ['@assignment.outer'] = 'V',           -- linewise
        ['@block.outer'] = 'V',                -- linewise
        ['@loop.outer'] = 'V',                 -- linewise
        ['@conditional.outer'] = 'V',          -- linewise
        ['@class.outer'] = 'V',                -- linewise
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
    swap = {
      enable = false,
      swap_next = {
        ["ml"] = "@parameter.inner",
        ["mj"] = "@statement.outer",
        ["mip"] = "@parameter.inner",
        ["mib"] = "@block.outer",
        ["mil"] = "@statement.outer",
        ["mif"] = "@function.outer",
        ["mic"] = "@class.outer",
        ["min"] = "@number.inner",
      },
      swap_previous = {
        ["mh"] = "@parameter.inner",
        ["mk"] = "@statement.outer",
        ["map"] = "@parameter.inner",
        ["mab"] = "@block.outer",
        ["mal"] = "@statement.outer",
        ["maf"] = "@function.outer",
        ["mac"] = "@class.outer",
        ["man"] = "@number.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,        -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]s"] = { query_group = "locals", query = "@scope" },
        ["]z"] = { query = "@fold", query_group = "folds" },
        ["]i"] = "@call.*",
        ["]d"] = "@conditional.*",
        ["]o"] = "@loop.*",
        ["]p"] = "@parameter.inner",
        ["]b"] = "@block.outer",
        ["]t"] = "@comment.*",
        ["]r"] = "@return.inner",
        ["]l"] = "@statement.*",
        ["]n"] = "@number.*",
        ["]h"] = "@assignment.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]S"] = { query = "@scope", query_group = "locals" },
        ["]Z"] = { query = "@fold", query_group = "folds" },
        ["]I"] = "@call.*",
        ["]D"] = "@conditional.*",
        ["]E"] = "@loop.*",
        ["]P"] = "@parameter.inner",
        ["]B"] = "@block.outer",
        ["]T"] = "@comment.*",
        ["]R"] = "@return.inner",
        ["]L"] = "@statement.*",
        ["]N"] = "@number.*",
        ["]H"] = "@assignment.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[s"] = { query = "@scope", query_group = "locals" },
        ["[z"] = { query = "@fold", query_group = "folds" },
        ["[i"] = "@call.*",
        ["[d"] = "@conditional.*",
        ["[e"] = "@loop.*",
        ["[p"] = "@parameter.inner",
        ["[b"] = "@block.outer",
        ["[t"] = "@comment.*",
        ["[r"] = "@return.inner",
        ["[l"] = "@statement.*",
        ["[n"] = "@number.*",
        ["[h"] = "@assignment.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[S"] = { query = "@scope", query_group = "locals" },
        ["[Z"] = { query = "@fold", query_group = "folds" },
        ["[I"] = "@call.*",
        ["[D"] = "@conditional.*",
        ["[E"] = "@loop.*",
        ["[P"] = "@parameter.*",
        ["[B"] = "@block.outer",
        ["[T"] = "@comment.*",
        ["[R"] = "@return.inner",
        ["[L"] = "@statement.*",
        ["[N"] = "@number.*",
        ["[H"] = "@assignment.outer",
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      -- goto_next = {
      --     ["]d"] = "@conditional.outer",
      -- },
      -- goto_previous = {
      --     ["[d"] = "@conditional.outer",
      -- }
    },
    lsp_interop = {
      enable = true,
      border = 'single',
      floating_preview_opts = {},
      peek_definition_code = {
        ["gsf"] = "@function.outer",
        ["gsc"] = "@class.outer",
      },
    },


  }
})

-- 开启 Folding 模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldenable = false
vim.opt.foldlevel = 99

