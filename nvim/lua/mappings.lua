-- keybings config
-- global keymap
-- vim.api.nvim_set_keymap({mode}, {key_from}, {key_to}, {options})
-- {mode}: 
-- n : Normal
-- i : Insert
-- v : Visual
-- t : Terminal
-- c : Command
-- vim.api.nvim_buf_set_keymap() buffer keymap

local M = {}

M.setup = function()

  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  local map = vim.api.nvim_set_keymap
  local opt = { noremap = true, silent = true }

  map("n", "<Esc>", ":noh<CR>", opt)

  map("n", "<A-h>", "<C-w>h", opt)
  map("n", "<A-j>", "<C-w>j", opt)
  map("n", "<A-k>", "<C-w>k", opt)
  map("n", "<A-l>", "<C-w>l", opt)
  map("n", "J", "10j", opt)
  map("n", "K", "10k", opt)

  map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
  map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
  map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
  map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

  map("v", "J", ":move '>+1<CR>gv-gv", opt)
  map("v", "K", ":move '<-2<CR>gv-gv", opt)
  map("v", "<", "<gv", opt)
  map("v", ">", ">gv", opt)

  map("n", "<C-M-q>", ":qa<CR>", opt)

-- nvim-tree
  map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

-- bufferline
  map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
  map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
  map("n", "<C-w>", ":bdelete<CR>", opt)

-- telescope
  map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- lsp
  map("n", "<A-.>", ":Lspsaga code_action<CR>", opt)

end

-- this is use for which key
M.normal = {
  ["<leader>"] = {
    ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "toggle comment" },
    k = { "<cmd>Lspsaga hover_doc<CR>", "hover" },
    s = {
      name = "window control",
      v = {"<cmd>vsp<CR>", "vertical split"},
      h = {"<cmd>sp<CR>", "horizontal split"},
      ['='] = {"<cmd>vertical resize+5<CR>", "vertical size+5"},
      ['-'] = {"<cmd>vertical resize-5<CR>", "vertical size-5"},
      ['j'] = {"<cmd>resize+3<CR>", "horizontal size+3"},
      ['k'] = {"<cmd>resize+3<CR>", "horizontal size+3"},
      ['e'] = {"<C-w>=", "size equal"},
    },
    f = {
      name = "find",
      f = { "<cmd>Telescope find_files<CR>", "find files" },
      w = {
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        "live_grep" },
      b = { "<cmd>Telescope buffers<CR>", "find buffers" },
      h = { "<cmd>Telescope help_tags<CR>", "help tags" },
      o = { "<cmd>AerialToggle<CR>", "find outline" },
    },
    -- gitsigns & diffview
    g = {
      name = "git",
      P = { "<cmd>DiffviewOpen<CR>", "diff project" },
      C = { "<cmd>DiffviewClose<CR>", "close diff project" },
      F = { "<cmd>DiffviewFileHistory<CR>", "file history" },
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "next hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "prev hunk" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "preview hunk" },
      d = { "<cmd>Gitsigns diffthis<CR>", "git diff" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "git blame" },
      b = { "<cmd>Telescope git_branches<CR>", "git branch" },
      s = { "<cmd>Telescope git_status<CR>", "git status" },
    },
    -- debug,
    D = {
      name = "debug",
      d = { "<cmd>Trouble document_diagnostics<CR>", "file diagnostics" },
      w = { "<cmd>Trouble document_diagnostics<CR>", "workspace diagnostics" },
    }
  },
  m = {
    -- bookmark
    name = "book mark",
    m = { "<cmd>BookmarkToggle<CR>", "bookmark" },
    i = { "<cmd>BookmarkAnnotate<CR>", "bookmark annotation" },
    a = { "<cmd>Telescope vim_bookmarks current_file<CR>", "show current file bookmarks" },
    A = { "<cmd>Telescope vim_bookmarks all<CR>", "show all bookmarks" },
  },
  g = {
    -- goto lsp
    name = "goto",
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "goto definition" },
    D = { "<cmd>Lspsaga peek_definition<CR>", "peek definition" },
    r = { "<cmd>Lspsaga finder<CR>", "find ref" },
    s = { "<cmd>Lspsaga show_line_diagnostics<CR>", "show line diag" },
  },
  ["["] = {
    -- d = { "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>", "prev diag"},
    d = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "prev diag"},
  },
  ["]"] = {
    -- d = { "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>", "next diag"},
    d = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "next diag"},
  },
  ["\\"] = { "<cmd>HopChar1<CR>", "jump"},
}

M.visual = {
  ["<leader>"] = {
    ["/"] = { "<Esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "toggle comment" },
  }
}

M.nvim_tree_map = {
  -- open file or folder
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edio" },
  -- spit open file
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- show hide files
  { key = "i", action = "toggle_custom" },
  { key = ".", action = "toggle_dotfiles" },

  { key = "<F5>", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
}

M.telescope = {
  i = {
    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",
    -- ["<C-k>"] = "preview_scrolling_up",
    -- ["<C-j>"] = "preview_scrolling_down",
  },
  n = {
    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",
    -- ["<C-k>"] = "preview_scrolling_up",
    -- ["<C-j>"] = "preview_scrolling_down",

    ["<Esc>"] = "close",
    ["?"] = "which_key",
  },
}

return M
