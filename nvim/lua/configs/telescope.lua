local telescope = require("telescope")
local keymap = require("mappings").telescope

telescope.setup({
  defaults = {
    -- insert default mode
    initial_mode = "insert",
    -- keymap
    mappings = keymap,
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_genneric_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("vim_bookmarks")
