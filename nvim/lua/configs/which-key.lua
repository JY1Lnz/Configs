local wk = require("which-key")
local mappings = require("mappings")

wk.setup({})

-- normal key mapping
wk.register(mappings.normal, {
  mode = "n",
  noremap = true,
  silent = true,
})

wk.register(mappings.visual, {
  mode = "v",
  noremap = true,
  silent = true,
})
