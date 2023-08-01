local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match("warning: multiple different client offset_encodings") then
    return
  end

  notify(msg, ...)
end

local clangd_config = {
  cmd = {
    "clangd",
    "--pretty",
    "-j=16",
    "--background-index",
    "--completion-style=detailed",
    "--clang-tidy",
    "--clang-tidy-checks=bugprone-*, clang-analyzer-*, google-*, modernize-*, performance-*, portability-*, readability-*, -bugprone-too-small-loop-variable, -clang-analyzer-cplusplus.NewDelete, -clang-analyzer-cplusplus.NewDeleteLeaks, -modernize-use-nodiscard, -modernize-avoid-c-arrays, -readability-magic-numbers, -bugprone-branch-clone, -bugprone-signed-char-misuse, -bugprone-unhandled-self-assignment, -clang-diagnostic-implicit-int-float-conversion, -modernize-use-auto, -modernize-use-trailing-return-type, -readability-convert-member-functions-to-static, -readability-make-member-function-const, -readability-qualified-auto, -readability-redundant-access-specifiers,",
    "--pch-storage=memory",
    "--cross-file-rename=true",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
  },
  flags = {
    debounce_text_changd = 150,
  },
  filetypes = {
    "c", "cpp", "objc", "cuda",
  },
  single_file_support = true,
}

require("lvim.lsp.manager").setup("clangd", clangd_config)

require("which-key").register({
  ["<leader>"] = {
    c = {
      name = "code",
      f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format code" },
    },
  },
}, { mode = "v", noremap = true, silent = true })

vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.relativenumber = true

lvim.lsp.buffer_mappings.normal_mode["gD"] = nil
lvim.lsp.buffer_mappings.normal_mode["gs"] = nil
lvim.lsp.buffer_mappings.normal_mode["gr"] = nil

-- mappings
local normal_map = lvim.keys.normal_mode
normal_map["<M-h>"] = "<C-w>h"
normal_map["<M-j>"] = "<C-w>j"
normal_map["<M-k>"] = "<C-w>k"
normal_map["<M-l>"] = "<C-w>l"
normal_map["J"] = "10j"
normal_map["K"] = "10k"
normal_map["<Esc>"] = ":noh<CR>"
normal_map["<C-p>"] = ":Telescope find_files<cr>"
normal_map["<M-m>"] = ":NvimTreeToggle<cr>"
normal_map["<C-M-q>"] = ":qa<CR>"
normal_map["<C-h>"] = ":BufferLineCyclePrev<CR>"
normal_map["<C-l>"] = ":BufferLineCycleNext<CR>"
normal_map["<C-w>"] = ":bd<CR>"
normal_map["<leader><Space>"] = ":Telescope buffers<CR>"
-- normal_map["gd"] = ":lua vim.lsp.buf.definition()<CR>"
normal_map["gD"] = ":Lspsaga peek_definition<CR>"
normal_map["gr"] = ":Lspsaga finder<CR>"
normal_map["gs"] = ":Lspsaga show_line_diagnostics<CR>"
normal_map["<F4>"] = ":lua require'dap'.terminate()<cr>"
normal_map["<F5>"] = ":lua require'dap'.continue()<cr>"
normal_map["<F9>"] = ":lua require'dap'.toggle_breakpoint()<cr>"
normal_map["<F10>"] = ":lua require'dap'.step_over()<cr>"
normal_map["<F11>"] = ":lua require'dap'.step_into()<cr>"
normal_map["<F12>"] = ":lua require'dap'.step_out()<cr>"
normal_map["mm"] = ":BookmarkToggle<cr>"
normal_map["mi"] = ":BookmarkAnnotate<cr>"
normal_map["ma"] = ":Telescope vim_bookmarks current_file<cr>"
normal_map["mA"] = ":Telescope vim_bookmarks all<cr>"
normal_map["H"] = "^"
normal_map["L"] = "$"


local visual_map = lvim.keys.visual_mode
visual_map["<M-j>"] = ":move '>+1<CR>gv-gv"
visual_map["<M-k>"] = ":move '<-2<CR>gv-gv"
visual_map["<"] = "<gv"
visual_map[">"] = ">gv"
visual_map["J"] = "5j"
visual_map["K"] = "5k"


local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<C-q>", "<C-\\><C-n>:q<CR>", opt)


local insert_map = lvim.keys.insert_mode
insert_map["jj"] = "<Esc>"

local lsp_normal_map = lvim.lsp.buffer_mappings.normal_mode
lsp_normal_map["K"] = nil
lsp_normal_map["gk"] = { vim.lsp.buf.hover, "Show documentation" }

local which_map = lvim.builtin.which_key.mappings
which_map['f'] = {
  name = "find",
  f = { "<cmd>Telescope find_files<cr>", "Find files" },
  F = { function()
    require("telescope.builtin").find_files({
      "fdfind",
      "-H",
      "-I",
      "-t",
      "f"
    })
  end, "Find all files" },
  w = { "<cmd>Telescope live_grep_args<CR>", "Live grep" },
  s = { "<cmd>Telescope lsp_document_symbols<CR>", "Find symbols" },
  S = { "<cmd>Telescope lsp_workspace_symbols<CR>", "Find all symbols" },
  o = { "<cmd>SymbolsOutline<CR>", "Find outline" },
  t = { "<cmd>TranslateW<CR>", "Translate" }
}
which_map['t'] = {
  name = "terminal",
  f = { "<cmd>ToggleTerm direction=float<CR>", "float term" },
  h = { "<cmd>ToggleTerm direction=horizontal<CR>", "horizontal term" },
  v = { "<cmd>ToggleTerm direction=vertical<CR>", "vertical term" },
}
which_map['k'] = { "<cmd>Lspsaga hover_doc<CR>", "Hover" }
which_map['K'] = { "<cmd>lua require('dapui').eval()<CR>", "Eval" }
which_map['s'] = {
  name = "split window",
  v = { "<cmd>vsp<CR>", "Vertical split" },
  h = { "<cmd>sp<CR>", "Horizontal split" },
}
which_map['d'] = {
  name = "debug",
  d = { function()
    require("dapui").float_element("repl", {
      width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
      height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
      enter = true,
      position = "center",
    })
  end, "Debug colsole" }
}

-- lvim.lsp.buffer_mappings.normal_mode.

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "json",
  "lua",
  "python",
  "yaml"
}

lvim.colorscheme = "onedark"

-- lvim.builtin.lualine.sections.lualine_a = { 'mode' }
lvim.builtin.lualine.sections.lualine_b = { 'filename' }
lvim.builtin.lualine.sections.lualine_c = { 'lsp_progress' }
-- lvim.builtin.lualine.sections.lualine_x = { '' }
-- lvim.builtin.lualine.sections.lualine_y = { '' }
-- lvim.builtin.lualine.sections.lualine_z = { '' }

-- lvim.builtin.indentlines.active = false

lvim.plugins = {
  -- {
  --   "JuanZoran/Trans.nvim",
  --   build = function() require 'Trans'.install() end,
  --   dependencies = { 'kkharji/sqlite.lua' },
  --   opts = {
  --     front
  --   },
  -- },
  -- {
  --   "voldikss/vim-translator",
  --   config = function()
  --     vim.g.translator_window_type = 'popup'
  --     vim.g.translator_default_engines = { 'google', 'bing' }
  --   end
  -- },
  -- {
  --   "ethanholz/nvim-lastplace",
  --   config = function()
  --     require("nvim-lastplace").setup({
  --       lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
  --       lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
  --       lastplace_open_folds = true,
  --     })
  --   end
  -- },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = 'right',
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = 'Pmenu',
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = { '', '' },
        wrap = false,
        keymaps = { -- These keymaps can be a string or a table for multiple keys
          close = { "<Esc>", "q" },
          goto_location = "<Cr>",
          focus_location = "o",
          hover_symbol = "<C-space>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
          File = { icon = "", hl = "@text.uri" },
          Module = { icon = "", hl = "@namespace" },
          Namespace = { icon = "", hl = "@namespace" },
          Package = { icon = "", hl = "@namespace" },
          Class = { icon = "𝓒", hl = "@type" },
          Method = { icon = "ƒ", hl = "@method" },
          Property = { icon = "", hl = "@method" },
          Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "ℰ", hl = "@type" },
          Interface = { icon = "", hl = "@type" },
          Function = { icon = "", hl = "@function" },
          Variable = { icon = "", hl = "@constant" },
          Constant = { icon = "", hl = "@constant" },
          String = { icon = "𝓐", hl = "@string" },
          Number = { icon = "#", hl = "@number" },
          Boolean = { icon = "⊨", hl = "@boolean" },
          Array = { icon = "", hl = "@constant" },
          Object = { icon = "⦿", hl = "@type" },
          Key = { icon = "🔐", hl = "@type" },
          Null = { icon = "NULL", hl = "@type" },
          EnumMember = { icon = "", hl = "@field" },
          Struct = { icon = "𝓢", hl = "@type" },
          Event = { icon = "🗲", hl = "@type" },
          Operator = { icon = "+", hl = "@operator" },
          TypeParameter = { icon = "𝙏", hl = "@parameter" },
          Component = { icon = "", hl = "@function" },
          Fragment = { icon = "", hl = "@constant" },
        },
      })
    end
  },
  { "arkav/lualine-lsp-progress" },
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
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
      })
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
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local null = require("null-ls")
      return {
        sources = {
          null.builtins.formatting.clang_format,
          null.builtins.formatting.clang_format.with({
            extra_args = { "-style=LLVM" }
          })
        }
      }
    end
  },
  {
    "JY1Lnz/onedark.nvim",
    version = "main"
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enable = true,
        event = { "InsertLeave", "TextChanged" },
        conditions = {
          exists = true,
          modifiable = true,
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135,
      })
    end
  },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  {
    "Shatur/neovim-session-manager",
    dependecies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local Path = require("plenary.path")
      local config = require("session_manager.config")
      require("session_manager").setup({
        session_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),
        session_filename_to_dir = session_filename_to_dir,
        dir_to_session_filename = dir_to_session_filename,
        autoload_mode = config.AutoloadMode.CurrentDir,
        autosave_last_session = true,
        autosave_ignore_not_normal = true,
        autosave_ignore_dirs = {},
        autosave_ignore_filetypes = {
          "gitcommit",
          "gitrebase",
        },
        autosave_ignore_buftypes = {},
        autosave_only_in_session = false,
        max_path_length = 80,
      })
    end
  },
  -- {
  --   "p00f/clangd_extensions.nvim",
  --   after = "mason-lspconfig.nvim",
  --   config = function()
  --     local provider = "clangd"
  --     local clangd_flags = {
  --       "clangd",
  --       "--pretty",
  --       "--background-index",
  --       "j=32",
  --       "--completion-sytle=detailed",
  --       "--clang-tidy",
  --       "--clang-tidy-checks=bugprone-*",
  --       "--pch-storage=memory",
  --       "--cross-file-rename=true",
  --       "--header-insertion=iwyu",
  --       "--header-insertion-decorators"
  --     }

  --     local custom_on_attach = function(client, bufnr)
  --       require("lvim.lsp").common_on_attach(client, bufnr)
  --       require("clangd_extensions.inlay_hints").setup_autocmd()
  --       require("clangd_extensions.inlay_hints").set_inlay_hints()
  --     end

  --     local custom_on_init = function(client, bufnr)
  --       require("lvim.lsp").common_on_init(client, bufnr)
  --       require("clangd_extensions.config").setup {}
  --       require("clangd_extensions.ast").init()
  --       vim.cmd [[
  --             command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
  --             command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
  --             command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
  --             command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
  --             command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
  --             ]]
  --     end

  --     local opts = {
  --       cmd = { provider, unpack(clangd_flags) },
  --       on_attach = custom_on_attach,
  --       on_init = custom_on_init,
  --     }

  --     require("lvim.lsp.manager").setup("clangd", opts)
  --   end
  -- },
  {
    "nvimdev/lspsaga.nvim",
    dependecies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lspsaga").setup({

      })
    end
  },
}

local nvimtree = lvim.builtin.nvimtree
nvimtree.setup.auto_reload_on_write = true
nvimtree.setup.actions.open_file.quit_on_open = true
nvimtree.setup.view.number = true
nvimtree.setup.view.relativenumber = true

local telescope = lvim.builtin.telescope

telescope.theme = "center"

telescope.defaults.layout_strategy = "horizontal"
telescope.defaults.layout_config.height = 0.9
telescope.defaults.layout_config.width = 0.9

telescope.defaults.mappings.i["<C-j>"] = "move_selection_next"
telescope.defaults.mappings.i["<C-k>"] = "move_selection_previous"
telescope.defaults.mappings.i["<C-n>"] = "cycle_history_next"
telescope.defaults.mappings.i["<C-p>"] = "cycle_history_prev"
telescope.defaults.mappings.i["<C-u>"] = "preview_scrolling_up"
telescope.defaults.mappings.i["<C-d>"] = "preview_scrolling_down"

telescope.defaults.mappings.n["<C-j>"] = "move_selection_next"
telescope.defaults.mappings.n["<C-k>"] = "move_selection_previous"
telescope.defaults.mappings.n["<C-n>"] = "cycle_history_next"
telescope.defaults.mappings.n["<C-p>"] = "cycle_history_prev"
telescope.defaults.mappings.n["<C-u>"] = "preview_scrolling_up"
telescope.defaults.mappings.n["<C-d>"] = "preview_scrolling_down"
telescope.defaults.mappings.n["q"] = "close"

telescope.pickers.buffers = {
  theme = "dropdown",
  previewer = false,
  layout_config = { width = 0.6 },
}

telescope.pickers.find_files = {
  theme = "dropdown",
  previewer = false,
  find_command = { "fdfind", "-t", "f" },
  layout_config = { width = 0.6 },
}

telescope.extensions.live_grep_args = {
  auto_quoting = true,
  layout_config = {
    preview_width = 0.5
  }
}


-- debug
lvim.builtin.dap.ui.config.floating.max_width = 0.9
lvim.builtin.dap.breakpoint.text = ''
lvim.builtin.dap.breakpoint_rejected.text = ''
lvim.builtin.dap.ui.config.layouts = {
  {
    elements = {
      -- Elements can be strings or table with id and size keys.
      { id = "scopes",      size = 0.3 },
      { id = "watches",     size = 0.25 },
      { id = "stacks",      size = 0.3 },
      { id = "breakpoints", size = 0.15 },
    },
    size = 40, -- 40 columns
    position = "left",
  },
  {
    elements = {
      -- "repl",
      "console",
    },
    size = 0.25, -- 25% of total lines
    position = "bottom",
  },
}

local dap = require("dap")
local dapui = require("dapui")

dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13123,
  executable = {
    command = '/home/jyl/.local/share/lvim/mason/bin/codelldb',
    args = { "--port", "13123" },
  },
}

-- dap.configurations.cpp = {
--   {
--     name = "test",
--     type = "codelldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--   }
-- }

require("dap.ext.vscode").load_launchjs(vim.fn.getcwd() .. "/.vscode/launch.json", {
  codelldb = { 'h', 'cpp' },
  debugpy = { 'py', 'python' }
})

local debug_open = function()
  dapui.open()

  vim.api.nvim_command("DapVirtualTextEnable")
  vim.api.nvim_command("NvimTreeClose")
end

local debug_close = function()
  dap.repl.close()
  dapui.close()
  vim.api.nvim_command("DapVirtualTextDisable")
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  debug_open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  debug_close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  debug_close()
end

dap.listeners.before.disconnect["dapui_config"] = function()
  debug_close()
end


-- cmp
--
lvim.builtin.cmp.formatting.kind_icons.Function = '󰊕'

local cmp = require("cmp")

lvim.builtin.cmp.mapping = cmp.mapping.preset.insert {
  ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  ["<A-,>"] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close()
  }),
  ["<C-j>"] = cmp.mapping.select_next_item(),
  ["<C-k>"] = cmp.mapping.select_prev_item(),
  ["<C-u>"] = cmp.mapping.scroll_docs(-4),

  ["<C-d>"] = cmp.mapping.scroll_docs(4),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    else
      fallback()
    end
  end),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      fallback()
    end
  end),
  ["<CR>"] = cmp.mapping.confirm({
    select = true,
    behavior = cmp.ConfirmBehavior.Replace
  }),
}

lvim.builtin.cmp.formatting.format = function(entry, vim_item)
  local max_width = 40
  if max_width ~= 0 and #vim_item.abbr > max_width then
    vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
  end
  vim_item.kind = lvim.builtin.cmp.formatting.kind_icons[vim_item.kind]
  vim_item.menu = lvim.builtin.cmp.formatting.source_names[entry.source.name]
  vim_item.dup = lvim.builtin.cmp.formatting.duplicates[entry.source.name]
      or lvim.builtin.cmp.formatting.duplicates_default
  return vim_item
end

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.insert {
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "n", "c" }),
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "n", "c" }),
  },
  sources = {
    { name = 'buffer' }
  }
})


cmp.setup.cmdline('?', {
  mapping = cmp.mapping.preset.insert {
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "n", "c" }),
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "n", "c" }),
  },
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.insert {
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "n", "c" }),
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "n", "c" }),
  },
  sources = cmp.config.sources({
    { name = 'cmdline' }
  }, {
    { name = 'path' }
  })
})


require("telescope").load_extension("live_grep_args")
vim.cmd('source ~/.config/lvim/syntax/llvm.vim')
vim.cmd('source ~/.config/lvim/syntax/machine-ir.vim')
vim.cmd('source ~/.config/lvim/syntax/mir.vim')
vim.cmd('source ~/.config/lvim/syntax/tablegen.vim')

local vim_config = function()
  vim.cmd([[
    augroup OpenCLFileType
      autocmd!
      autocmd BufRead,BufNewFile *.cl setlocal filetype=cpp
    augroup END
  ]])
  vim.cmd([[
    au BufRead,BufNewFile *.ll set filetype=llvm
  ]])
  vim.cmd([[
    au BufNewFile,BufRead *.td set filetype=tablegen
  ]])
end

vim_config()
