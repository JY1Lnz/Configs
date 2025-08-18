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

  map("i", "jj", "<Esc>", opt)

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

  map("v", "<A-j>", ":move '>+1<CR>gv-gv", opt)
  map("v", "<A-k>", ":move '<-2<CR>gv-gv", opt)
  map("v", "<", "<gv", opt)
  map("v", ">", ">gv", opt)
  map("v", "J", "10j", opt)
  map("v", "K", "10k", opt)

-- terminal
  -- map("n", "<C-d>", "<cmd>ToggleTerm direction=float<CR>", opt)
  -- map("t", "<C-d>", "<cmd>ToggleTerm direction=float<CR>", opt)

-- nvim-tree
  map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

-- bufferline
  map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
  map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)

-- telescope
  map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- lsp
  -- map("n", "<A-.>", ":Lspsaga code_action<CR>", opt)
-- terminal
  -- map("t", "<Esc>", "<C-\\><C-n>", opt)
  map("t", "<C-q>", "<C-\\><C-n>:q<CR>", opt)
  -- Dap
  map("n", "<F3>", ":lua require'dapui'.toggle()<CR>", opt)
  map("n", "<F4>", ":DapTerminate<CR>", opt)
  map("n", "<F5>", ":DapContinue<CR>", opt)
  map("n", "<F10>", ":DapStepOver<CR>", opt)
  map("n", "<F9>", ":DapToggleBreakpoint<CR>", opt)
  map("n", "<F11>", ":DapStepInto<CR>", opt)
  map("n", "<F12>", ":DapStepOut<CR>", opt)

  map("n", "<M-o>", ":ClangdSwitchSourceHeader<CR>", opt)

end

M.which_key = {
  {
    "<C-d>",
    function()
      if (not require('custom/state').get_debug()) then
        vim.api.nvim_command('ToggleTerm direction=float')
      else
        require("dapui").float_element("console", {
          width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
          height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
          enter = true,
          position = "center",
        })
      end
    end,
    desc = "toggle terminal",
    mode = { "n", "v", "t" }
  },
  { "<A-k>", "<C-w>k", mode = {"n"} },
  { "<leader><space>", "<cmd>Telescope buffers<CR>", desc = "buffer file", mode = {"n"} },
  { "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", desc = "toggle comment", mode = {"n"} },
  { "<leader>/", "<Esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", desc = "toggle select comment", mode = {"v"} },
  { "<leader>f", "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<CR>", desc = "grep select", mode = {"v"} },
  { "<leader>l", function()
    require("flash").jump({
      search = { mode = "search", max_length = 0 },
      label = { after = { 0, 0 } },
      pattern = "^",
    })
  end, desc = "jump to a line", mode = {"n", "v"} },
  { "<leader>w", function()
    require("flash").jump({
      pattern = ".", -- initialize pattern with any char
      search = {
        mode = function(pattern)
          -- remove leading dot
          if pattern:sub(1, 1) == "." then
            pattern = pattern:sub(2)
          end
          -- return word pattern and proper skip pattern
          return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
        end,
      },
      -- select the range
      -- jump = { pos = "range" },
    })
  end, desc = "jump to a word", mode = {"n", "v"}},
  { "<leader>k", "<cmd>lua require('hover').hover()<CR>", desc = "hover", mode = {"n"} },
  { "<leader>K", "<cmd>lua require('dapui').eval()<CR>", desc = "eval hover", mode = {"n"} },
  -- c: code
  { "<leader>c", group = "code" },
  { "<leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "format code", mode = {"n", "v"} },
  { "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "code action", mode = {"n"} },
  { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "rename", mode = {"n"} },
  { "<leader>ci", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, desc = "inlayhints toggle", mode = {"n"} },
  { "<leader>cc", ":OSCYankVisual<CR>", desc = "copy", mode = {"v"} },

  -- f: find
  { "<leader>f", group = "find" },
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "find files", mode = {"n"} },
  { "<leader>fF", function()
    require("telescope.builtin").find_files({
      find_command = {
        "fdfind",
        "-H",
        "-I",
        "-t",
        "f"
      }})
  end, desc = "find files and display ignore", mode = {"n"} },
  { "<leader>fw", function()
    require("telescope").extensions.live_grep_args.live_grep_args({})
  end, desc = "live_grep", mode = {"n"} },
  { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "find help", mode = {"n"} },
  { "<leader>fo", "<cmd>AerialToggle!<CR>", desc = "find outline", mode = {"n"} },
  -- { "<leader>ft", "<cmd>TranslateW<CR>", desc = "translate", mode = { "n" } },
  { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "find symbols", mode = {"n"} },
  { "<leader>fS", function()
    vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
      require('telescope.builtin').lsp_workspace_symbols({ query = query })
    end)
  end, desc = "find workspace symbols", mode = {"n"} },
  { "<leader>fm", "<cmd>Telescope bookmarks list<CR>", desc = "show current file bookmarks", mode = {"n"} },

  -- m: bookmark
  { "m", group = "bookmark" },
  { "mm", function()
    require('bookmarks').bookmark_toggle()
  end, desc = "bookmark", mode = {"n"} },
  { "mi", function()
    require('bookmarks').bookmark_ann()
  end, desc = "bookmark with annoate", mode = {"n"} },
  { "mc", function()
    require('bookmarks').bookmark_clean()
  end, desc = "clean buffer bookmarks", mode = {"n"} },
  { "mC", function()
    require('bookmarks').bookmark_clear_all()
  end, desc = "clean all bookmarks", mode = {"n"} },

  -- g: goto
  { "g", group = "goto" },
  { "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "goto definition", mode = {"n"} },
  -- { "gD", "<cmd>Lspsaga peek_definition<CR>", desc = "peek definition", mode = {"n"} },
  { "gD", "<cmd>Lspsaga peek_definition<CR>", desc = "peek definition", mode = {"n"} },
  -- { "gr", "<cmd>Lspsaga finder<CR>", desc = "goto reference", mode = {"n"} },
  { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "goto reference", mode = {"n"} },
  { "gs", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "show line diga", mode = {"n"} },
  { "gK", "<cmd>lua require('hover').hover_select()<CR>", desc = "hove", mode = {"n"} },
  { "g]", function ()
    require('gitsigns').next_hunk()
  end, desc = "next hunk", mode = { "n" } },
  { "g[", function ()
    require('gitsigns').prev_hunk()
  end, desc = "prev hunk", mode = { "n" } },
  { "gp", function ()
    require('gitsigns').preview_hunk()
  end, desc = "preview hunk", mode = { "n" } },
  { "gP", function ()
    require('gitsigns').preview_hunk_inline()
  end, desc = "preview hunk inline", mode = { "n" } },

  { "tf", "<cmd>ToggleTerm direction=float<CR>", desc = "toggle float terminal", mode = {"n"} },
  { "th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "toggle horizontal terminal", mode = {"n"} },
  { "tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "toggle vertical terminal", mode = {"n"} },
  { "tt" , "<cmd>ToggleTerm direction=tab<CR>", desc = "toggle tab terminal", mode = {"n"} },

  -- diagnostic
  { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "goto prev diagnostic", mode = {"n"} },
  { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "goto next diagnostic", mode = {"n"} },

  -- s: window control
  { "<leader>s", group = "window control" },
  { "<leader>sv", "<cmd>vsp<CR>", desc = "vertical split", mode = {"n"} },
  { "<leader>sh", "<cmd>sp<CR>", desc = "horizontal split", mode = {"n"} },
  { "<leader>sr", "<cmd>WinResizerStartResize<CR>", desc = "resize window", mode = {"n"} },

  -- g: git
  { "<leader>g",  group = "git" },
  {
    "<leader>gt",
    "<cmd>DiffviewToggleFiles<CR>",
    desc = "diffview toggle file panel",
    mode = { "n" }
  },
  { "<leader>gg", "<cmd>:LazyGit<CR>", desc = "lazygit", mode = { "n" } },
  { "<leader>gf", "<cmd>:LazyGitFilter<CR>", desc = "lazygit", mode = { "n" } },
  { "<leader>gn", "<cmd>:LazyGitFilterCurrentFile<CR>", desc = "lazygit", mode = { "n" } },

  -- d: debug
  { "<leader>d", group = "debug" },
  { "<leader>ds", function()
    require("dapui").float_element("stacks", {
      width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
      height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
      enter = true,
      position = "center",
    })
  end, desc = "show stack", mode = {"n"} },
  { "<leader>dr", function()
    require("dapui").float_element("repl", {
      width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
      height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
      enter = true,
      position = "center",
    })
  end, desc = "show repl", mode = {"n"} },
  { "<leader>de", function()
    Exec();
  end, desc = "Exec", mode = {"n"} },
  {
    "<leader>dd",
    function()
      if require('custom/state').get("diff_view") then
        require('custom/state').set("diff_view", false)
        vim.api.nvim_command('DiffviewClose')
      else
        require('custom/state').set("diff_view", true)
        vim.api.nvim_command('DiffviewOpen')
      end
    end,
    desc = "diffview open",
    mode = { "n" }
  },
  {
    "<leader>df",
    function()
      if require('custom/state').get("diff_view_file") then
        require('custom/state').set("diff_view_file", false)
        vim.api.nvim_command('tabclose')
      else
        require('custom/state').set("diff_view_file", true)
        vim.api.nvim_command('DiffviewFileHistory')
      end
    end,
    desc = "diffview file history",
    mode = { "n" }
  },
  {
    "<leader>dn",
    function()
      if require('custom/state').get("diff_view_file") then
        require('custom/state').set("diff_view_file", false)
        vim.api.nvim_command('tabclose')
      else
        require('custom/state').set("diff_view_file", true)
        vim.api.nvim_command('DiffviewFileHistory %')
      end
    end,
    desc = "diffview file history",
    mode = { "n" }
  },

  -- t: t
  { "<leader>t", group = "Trouble" },
  { "<leader>tb", "<cmd>Trouble diagnostics focus=true<CR>", desc = "buffer diagnostics", mode = {"n"} },
  { "<leader>te", "<cmd>Trouble diagnostics filter = { severity=vim.diagnostic.severity.ERROR }<CR>", desc = "buffer error", mode = {"n"} },
}

-- this is use for which key
M.normal = {
  ["<leader>"] = {
    c = {
    },
    -- gitsigns & diffview
    g = {
      name = "git",
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "next hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "prev hunk" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "preview hunk" },
      d = { "<cmd>Gitsigns diffthis<CR>", "git diff" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "git blame" },
      b = { "<cmd>Telescope git_branches<CR>", "git branch" },
      s = { "<cmd>Telescope git_status<CR>", "git status" },
      g = { "<cmd>LazyGit<CR>", "lazy git" },
    },
    -- debug,
    d = {
      name = "debug",
      b = { "<cmd>Trouble document_diagnostics<CR>", "buffer diagnostics" },
      w = { "<cmd>Trouble workspace_diagnostics<CR>", "workspace diagnostics" },
      v = { "<cmd>DapVirtualTextToggle<CR>", "dap virtual txt toggle" },
      d = { function ()
        require("dapui").float_element("repl", {
          width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
          height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
          enter = true,
          position = "center",
        })
      end, "debug console" },
      t = { function ()
        require("dapui").float_element("console", {
          width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
          height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
          enter = true,
          position = "center",
        })
      end, "debug terminal" },
      s = { function ()
        require("dapui").float_element("stacks", {
          width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
          height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
          enter = true,
          position = "center",
        })
      end, "debug stacks" },
    }
  },
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
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
  },
  n = {
    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",

    ["q"] = "close",
    ["?"] = "which_key",
  },
}

return M
