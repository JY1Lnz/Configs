local nt = require("nvim-tree")
-- local list_keys = require("mappings").nvim_tree_map

local function my_on_attach(bufnr)
  local api = require ("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', ',', api.tree.toggle_gitignore_filter, opts("help"))
  vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts("help"))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts("help"))
  vim.keymap.set('n', 'h', api.node.open.horizontal, opts("help"))

end

nt.setup({
  on_attach = my_on_attach,
  git = {
    enable = true,
    ignore = true,
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
    dotfiles = true,
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
