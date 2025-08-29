return {
  "nvim-tree/nvim-tree.lua",
  requires = "nvim-tree/nvim-web-devicons",
  config = function()
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    end
    require("nvim-tree").setup({
      on_attach = my_on_attach,
      git = {
        enable = true,
        ignore = false,
      },
      view = {
        width = 50,
        side = 'left',
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
      },

    })
  end
}
