local telescope = require("telescope")
local keymap = require("mappings").telescope

telescope.setup({
  defaults = {
    -- insert default mode
    initial_mode = "insert",
    -- keymap
    mappings = keymap,

    layout_strategy = 'horizontal',
    layout_config = { height = 0.9 , width = 0.9 },

  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
      find_command = { "fdfind" , "-t", "f"},
      layout_config = { width = 0.7 },
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      layout_config = { width = 0.7 },
    },
    lsp_document_symbols = {
      layout_config = { preview_width = 0.5 },
    },
    lsp_workspace_symbols = {
      layout_config = { preview_width = 0.5 },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_genneric_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    live_grep_args = {
      auto_quoting = true,
      layout_config = {
        preview_width = 0.5
      }
    }
  },
})

-- Token    Match type                  Description
--
-- sbtrkt   fuzzy-match                 Items that match sbtrkt
-- 'wild    exact-match (quoted)        Items that include wild
-- ^music   prefix-exact-match Items    that start with music
-- .mp3$    suffix-exact-match Items    that end with .mp3
-- !fire    inverse-exact-match Items   that do not include fire
-- !^music  inverse-prefix-exact-match  Items that do not start with music
-- !.mp3$   inverse-suffix-exact-match  Items that do not end with .mp3

telescope.load_extension("fzf")
telescope.load_extension("bookmarks")
telescope.load_extension("live_grep_args")
-- telescope.load_extension("projects")
