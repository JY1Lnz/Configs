local nt = require("nvim-tree")
local list_keys = require("mappings").nvim_tree_map

nt.setup({
  git = {
    enable = true,
    ignore = false,
  },
  view = {
    width = 50,
    side = 'left',
    hide_root_folder = false,
    mappings = {
      custom_only = false,
      -- list = list_keys,
    },
    -- number line
    number = true,
    relativenumber = true,

    -- show icons
    signcolumn = 'yes',

  },
  filters = {
    dotfiles = false,
    custom = { '.git' },
  },
  actions = {
    open_file = {
      resize_window = true,
      quit_on_open = true,
    }
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  }
})

vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
