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

local RegisterDotRepeatCmd = function(cmd, name)
  vim.api.nvim_set_keymap("n", "DotRepeat" .. name, ":" .. cmd .. "<CR>", { noremap = true, silent = true })
  return function()
    vim.cmd(cmd)
    vim.fn["repeat#set"]("DotRepeat" .. name, vim.v.count)
  end
end

local wk = require("which-key")
wk.add({
  { "jj",         "<Esc>",                            hidden = true,             mode = { "i" },      noremap = true, silent = true },
  { "<Esc>",      ":noh<CR>",                         hidden = true,             mode = { "n" },      noremap = true, silent = true },
  { "<C-h>",      "<C-w>h",                           mode = { "n" },            noremap = true,      silent = true },
  { "<C-j>",      "<C-w>j",                           mode = { "n" },            noremap = true,      silent = true },
  { "<C-k>",      "<C-w>k",                           mode = { "n" },            noremap = true,      silent = true },
  { "<C-l>",      "<C-w>l",                           mode = { "n" },            noremap = true,      silent = true },
  { "J",          "10j",                              hidden = true,             mode = { "n", "v" }, noremap = true, silent = true },
  { "K",          "10k",                              hidden = true,             mode = { "n", "v" }, noremap = true, silent = true },
  { ">",          ">gv",                              hidden = true,             mode = { "v" },      noremap = true, silent = true },
  { "<",          "<gv",                              hidden = true,             mode = { "v" },      noremap = true, silent = true },
  { "gb",         ":NvimTreeToggle<CR>",              mode = { "n" },            noremap = true,      silent = true },
  -- buffer line keymap
  { "[b",         ":BufferLineCyclePrev<CR>",         mode = { "n" },            noremap = true,      silent = true },
  { "]b",         ":BufferLineCycleNext<CR>",         mode = { "n" },            noremap = true,      silent = true },

  { "<leader>sv", "<cmd>vsp<CR>",                     desc = "vertical split",   mode = { "n" } },
  { "<leader>sh", "<cmd>sp<CR>",                      desc = "horizontal split", mode = { "n" } },

  -- dap keymap
  { "<F3>",       ":lua require'dapui'.toggle()<CR>", mode = { "n" },            noremap = true,      silent = true },
  { "<F4>",       ":DapTerminate<CR>",                mode = { "n" },            noremap = true,      silent = true },
  { "<F5>",       ":DapContinue<CR>",                 mode = { "n" },            noremap = true,      silent = true },
  { "<F9>",       ":DapToggleBreakpoint<CR>",         mode = { "n" },            noremap = true,      silent = true },
  { "<F10>",      ":DapStepOver<CR>",                 mode = { "n" },            noremap = true,      silent = true },
  { "<F11>",      ":DapStepInto<CR>",                 mode = { "n" },            noremap = true,      silent = true },
  { "<F12>",      ":DapStepOut<CR>",                  mode = { "n" },            noremap = true,      silent = true },
  {
    "<C-e>",
    function()
      -- if (not require('custom/state').get_debug()) then
      vim.api.nvim_command('ToggleTerm direction=float')
      -- else
      --   require("dapui").float_element("console", {
      --     width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
      --     height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
      --     enter = true,
      --     position = "center",
      --   })
      -- end
    end,
    mode = { "n", "v", "t", "i" },
    noremap = true,
    silent = true
  },
  -- flash
  {
    "<leader>l",
    function()
      require("flash").jump({
        search = {
          mode = "search",
          max_length = 0,
        },
        label = { after = { 0, 0 } },
        pattern = "^",
      })
    end,
    mode = { "n", "v" },
    desc = "Jump to a line",
    noremap = true,
    silent = true
  },
  {
    "<leader>w",
    function()
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
    end,
    desc = "jump to a word",
    mode = { "n", "v" }
  },
  { "<leader>k",        "<cmd>lua require('hover').hover()<CR>", desc = "hover",             mode = { "n" } },
  -- { "<leader>K",  "<cmd>lua require('dapui').eval()<CR>",  desc = "eval hover",  mode = { "n" } },
  -- Find FzfLua
  { "<leader><leader>", ":FzfLua buffers<CR>",                   desc = "Find buffers",      mode = { "n" } },
  { "<leader>ff",       ":FzfLua files<CR>",                     desc = "Find files",        mode = { "n" } },
  { "<leader>fgg",      ":FzfLua grep<CR>",                      desc = "Fzf grep",          mode = { "n" } },
  { "<leader>fgq",      ":FzfLua qrep_quickfix<CR>",             desc = "Fzf grep quickfix", mode = { "n" } },

  -- QuickFix
  {
    "<leader>cc",
    function()
      local function is_quickfix_open()
        local qf_winid = vim.fn.getqflist({ winid = 1 }).winid
        return qf_winid ~= 0 -- 返回 true（已打开）或 false（未打开）
      end
      if is_quickfix_open() then
        vim.cmd('cclose')
      else
        vim.cmd('copen')
      end
    end
    ,
    desc = "Quickfix ",
    mode = { "n" },
    noremap = true,
    silent = true,
  },
  {
    "[q",
    RegisterDotRepeatCmd("cprevious", "CPrev"),
    desc = "do cprevious",
    mode = { "n" },
    noremap = true,
    silent = true,
  },
  {
    "]q",
    RegisterDotRepeatCmd("cnext", "CNext"),
    desc = "do cnext",
    mode = { "n" },
    noremap = true,
    silent = true,

  },


  { "gso", ":AerialToggle<CR>",                             desc = "Toggle Aerial",        mode = { "n" } },
  { "go",  "<cmd>LspClangdSwitchSourceHeader<CR>",          desc = "Header Source switch", mode = { "n" } },
  { "gO",  "<cmd>vsplit | LspClangdSwitchSourceHeader<CR>", desc = "Header Source switch", mode = { "n" }, silent = true },

  {
    "<leader>sl",
    function()
      require("persistence").load()
    end,
    desc = "Load session",
    mode = { "n" },
    silent = true
  },
  {
    "<leader>ss",
    function()
      require("persistence").select()
    end,
    desc = "Load session",
    mode = { "n" },
    silent = true
  },

  -- format
  { "<leader>cf",  "<cmd>lua vim.lsp.buf.format()<CR>",                                       desc = "format code",          mode = { "n", "v" } },
  {
    "<leader>ci",
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
    desc = "inlayhints toggle",
    mode = { "n" }
  },

  -- diagnostic
  { "[d",          "<cmd>Lspsaga diagnostic_jump_prev<CR>",                                   desc = "goto prev diagnostic", mode = { "n" } },
  { "]d",          "<cmd>Lspsaga diagnostic_jump_next<CR>",                                   desc = "goto next diagnostic", mode = { "n" } },

  -- git signs
  { "<leader>grb", "<cmd>Gitsigns reset_buffer",                                              desc = "git reset buffer",     mode = { "n" } },
  { "<leader>grh", "<cmd>Gitsigns reset_hunk",                                                desc = "git reset hunk",       mode = { "n" } },
  -- { "<leader>gg",  "<cmd>LazyGit<CR>",                                                        desc = "LazyGit",              mode = { "n" } },
  -- { "<leader>gb",  "<cmd>Telescope git_branches<CR>",                                         desc = "git branch",           mode = { "n" } },
  -- { "<leader>gs",  "<cmd>Telescope git_status<CR>",                                           desc = "git status",           mode = { "n" } },
  { "<leader>gl",  "<cmd>lua require 'gitsigns'.blame_line()<CR>",                            desc = "git line blame",       mode = { "n" } },
  { "[g",          RegisterDotRepeatCmd("lua require 'gitsigns'.prev_hunk()", "GitPrevHunk"), desc = "git prev hunk",        mode = { "n" } },
  { "]g",          RegisterDotRepeatCmd("lua require 'gitsigns'.next_hunk()", "GitNextHunk"), desc = "git next hunk",        mode = { "n" } },
  { "<leader>gp",  "<cmd>lua require 'gitsigns'.preview_hunk()<CR>",                          desc = "preview hunk",         mode = { "n" } },

})

local M = {}
M.setup = function()
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  local map = vim.api.nvim_set_keymap
  local opt = { noremap = true, silent = true }

  map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
  map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
  map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
  map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

  map("v", "<A-j>", ":move '>+1<CR>gv-gv", opt)
  map("v", "<A-k>", ":move '<-2<CR>gv-gv", opt)

  -- terminal
  -- map("n", "<C-d>", "<cmd>ToggleTerm direction=float<CR>", opt)
  -- map("t", "<C-d>", "<cmd>ToggleTerm direction=float<CR>", opt)

  -- lsp
  -- map("n", "<A-.>", ":Lspsaga code_action<CR>", opt)
  -- terminal
  -- map("t", "<Esc>", "<C-\\><C-n>", opt)
  -- map("t", "<C-q>", "<C-\\><C-n>:q<CR>", opt)
  -- Dap
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
    mode = { "n", "v", "t", "i" },
    silent = true,
  },
  { "<leader><space>", "<cmd>Telescope buffers<CR>",                                                         desc = "buffer file",           mode = { "n" } },
  { "<leader>/",       "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",                      desc = "toggle comment",        mode = { "n" } },
  { "<leader>/",       "<Esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",      desc = "toggle select comment", mode = { "v" } },
  { "<leader>f",       "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<CR>", desc = "grep select",           mode = { "v" } },
  {
    "<leader>w",
    function()
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
    end,
    desc = "jump to a word",
    mode = { "n", "v" }
  },
  { "<leader>k",  "<cmd>lua require('hover').hover()<CR>", desc = "hover",       mode = { "n" } },
  { "<leader>K",  "<cmd>lua require('dapui').eval()<CR>",  desc = "eval hover",  mode = { "n" } },
  -- c: code
  { "<leader>c",  group = "code" },
  { "<leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>",     desc = "format code", mode = { "n", "v" } },
  { "<leader>ca", "<cmd>Lspsaga code_action<CR>",          desc = "code action", mode = { "n" } },
  { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>",     desc = "rename",      mode = { "n" } },
  {
    "<leader>ci",
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
    desc = "inlayhints toggle",
    mode = { "n" }
  },
  { "<leader>cc", ":OSCYankVisual<CR>", desc = "copy", mode = { "v" } },
  {
    "<leader>cc",
    function()
      local function is_quickfix_open()
        local qf_winid = vim.fn.getqflist({ winid = 1 }).winid
        return qf_winid ~= 0 -- 返回 true（已打开）或 false（未打开）
      end
      if is_quickfix_open() then
        vim.cmd('cclose')
      else
        vim.cmd('copen')
      end
    end,
    desc = "quick fix",
    mode = { "n" }
  },

  -- f: find
  { "<leader>f",  group = "find" },
  {
    "<leader>ff",
    function()
      require("telescope.builtin").find_files({
        find_command = {
          "fd",
          "-t",
          "f"
        }
      })
    end,
    desc = "find files",
    mode = { "n" }
  },
  {
    "<leader>fF",
    function()
      require("telescope.builtin").find_files({
        find_command = {
          "fd",
          "-H",
          "-I",
          "-t",
          "f"
        }
      })
    end,
    desc = "find files and display ignore",
    mode = { "n" }
  },
  {
    "<leader>fw",
    function()
      require("telescope").extensions.live_grep_args.live_grep_args({})
    end,
    desc = "live_grep",
    mode = { "n" }
  },
  { "<leader>fh", "<cmd>Telescope help_tags<CR>",            desc = "find help",    mode = { "n" } },
  { "<leader>fo", "<cmd>AerialToggle!<CR>",                  desc = "find outline", mode = { "n" } },
  -- { "<leader>ft", "<cmd>TranslateW<CR>", desc = "translate", mode = { "n" } },
  { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "find symbols", mode = { "n" } },
  {
    "<leader>fS",
    function()
      vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
        require('telescope.builtin').lsp_workspace_symbols({ query = query })
      end)
    end,
    desc = "find workspace symbols",
    mode = { "n" }
  },
  { "<leader>fm", "<cmd>Telescope bookmarks list<CR>",         desc = "show current file bookmarks", mode = { "n" } },

  -- m: bookmark
  -- { "m",          group = "bookmark" },
  -- {
  --   "mm",
  --   function()
  --     require('bookmarks').bookmark_toggle()
  --   end,
  --   desc = "bookmark",
  --   mode = { "n" }
  -- },
  -- {
  --   "mi",
  --   function()
  --     require('bookmarks').bookmark_ann()
  --   end,
  --   desc = "bookmark with annoate",
  --   mode = { "n" }
  -- },
  -- {
  --   "mc",
  --   function()
  --     require('bookmarks').bookmark_clean()
  --   end,
  --   desc = "clean buffer bookmarks",
  --   mode = { "n" }
  -- },
  -- {
  --   "mC",
  --   function()
  --     require('bookmarks').bookmark_clear_all()
  --   end,
  --   desc = "clean all bookmarks",
  --   mode = { "n" }
  -- },

  -- g: goto
  { "g",          group = "goto" },
  { "gd",         "<cmd>Lspsaga goto_definition<CR>",          desc = "goto definition",             mode = { "n" } },
  -- { "gD", "<cmd>Lspsaga peek_definition<CR>", desc = "peek definition", mode = {"n"} },
  { "gD",         "<cmd>Lspsaga peek_definition<CR>",          desc = "peek definition",             mode = { "n" } },
  -- { "gr", "<cmd>Lspsaga finder<CR>", desc = "goto reference", mode = {"n"} },
  { "gr",         "<cmd>lua vim.lsp.buf.references()<CR>",     desc = "goto reference",              mode = { "n", "v" } },
  { "gR",         "<cmd>Telescope lsp_references<CR>",         desc = "Telescope reference",         mode = { "n", "v" } },
  { "gk",         "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "signature",                   mode = { "n" } },
  { "gs",         "<cmd>Lspsaga show_line_diagnostics<CR>",    desc = "show line diga",              mode = { "n" } },
  { "gK",         "<cmd>lua require('hover').hover()<CR>",     desc = "hove",                        mode = { "n" } },
  {
    "g]",
    function()
      require('gitsigns').next_hunk()
    end,
    desc = "next hunk",
    mode = { "n" }
  },
  {
    "g[",
    function()
      require('gitsigns').prev_hunk()
    end,
    desc = "prev hunk",
    mode = { "n" }
  },
  {
    "gp",
    function()
      require('gitsigns').preview_hunk()
    end,
    desc = "preview hunk",
    mode = { "n" }
  },
  {
    "gP",
    function()
      require('gitsigns').preview_hunk_inline()
    end,
    desc = "preview hunk inline",
    mode = { "n" }
  },
  { "gh",         "(v:count == 0 || v:count == 1 ? '^^' : '^^' . (v:count - 1) . 'l')", desc = "Move to left.",              mode = { "n", "v", }, silent = true, expr = true },
  { "gl",         "(v:count == 0 || v:count == 1 ? '^$' : '^$' . (v:count - 1) . 'h')", desc = "Move to right.",             mode = { "n", "v", }, silent = true, expr = true },
  { "go",         "<cmd>ClangdSwitchSourceHeader<CR>",                                  desc = "Header Source switch",       mode = { "n", "v" } },
  { "gO",         "<cmd>vsplit | ClangdSwitchSourceHeader<CR>",                         desc = "Header Source switch",       mode = { "n", "v" },  silent = true },
  { "gy",         "<cmd>Telescope lsp_type_definitions<CR>",                            desc = "Find type def",              mode = { "n", "v" } },
  { "gsp",        "<cmd>NvimTreeFindFileToggle<CR>",                                    desc = "NvimTree",                   mode = { "n", "v" } },

  { "gst",        "<cmd>lua vim.lsp.buf.typehierarchy('subtypes')<CR>",                 desc = "subtypes",                   mode = { "n", "v" } },
  { "gsT",        "<cmd>lua vim.lsp.buf.typehierarchy('supertypes')<CR>",               desc = "subtypes",                   mode = { "n", "v" } },


  { "tf",         "<cmd>ToggleTerm direction=float<CR>",                                desc = "toggle float terminal",      mode = { "n" } },
  { "th",         "<cmd>ToggleTerm direction=horizontal<CR>",                           desc = "toggle horizontal terminal", mode = { "n" } },

  { "tv",         "<cmd>ToggleTerm direction=vertical<CR>",                             desc = "toggle vertical terminal",   mode = { "n" } },
  { "tt",         "<cmd>ToggleTerm direction=tab<CR>",                                  desc = "toggle tab terminal",        mode = { "n" } },

  -- diagnostic
  { "[d",         "<cmd>Lspsaga diagnostic_jump_prev<CR>",                              desc = "goto prev diagnostic",       mode = { "n" } },
  { "]d",         "<cmd>Lspsaga diagnostic_jump_next<CR>",                              desc = "goto next diagnostic",       mode = { "n" } },
  -- quick fix
  { "[q",         RegisterDotRepeatCmd("cprevious", "CPrev"),                           desc = "do cprevious",               mode = { "n" } },
  { "]q",         RegisterDotRepeatCmd("cnext", "CNext"),                               desc = "do cnext",                   mode = { "n" } },


  -- d: debug
  { "<leader>d",  group = "debug" },
  { "]s",         RegisterDotRepeatCmd("lua require('dap').down()", "DapStackDown"),    desc = "Dap Stack Down",             mode = { "n" } },
  { "[s",         RegisterDotRepeatCmd("lua require('dap').up()", "DapStackUp"),        desc = "Dap Stack Up",               mode = { "n" } },
  { "<leader>dv", "<cmd>DapVirtualTextToggle<CR>",                                      desc = "Dap virtual text toggle",    mode = { "n" } },
  {
    "<leader>ds",
    function()
      require("dapui").float_element("stacks", {
        width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
        height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
        enter = true,
        position = "center",
      })
    end,
    desc = "show stack",
    mode = { "n" }
  },
  {
    "<leader>dr",
    function()
      require("dapui").float_element("repl", {
        width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
        height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
        enter = true,
        position = "center",
      })
    end,
    desc = "show repl",
    mode = { "n" }
  },
  {
    "<leader>de",
    function()
      Exec();
    end,
    desc = "Exec",
    mode = { "n" }
  },
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
  { "<leader>t",   group = "Trouble" },
  { "<leader>tb",  "<cmd>Trouble diagnostics toggle<CR>",                                              desc = "buffer diagnostics", mode = { "n" } },
  { "<leader>te",  "<cmd>Trouble diagnostics filter = { severity=vim.diagnostic.severity.ERROR }<CR>", desc = "buffer error",       mode = { "n" } },

  -- git
}


-- this is use for which key
M.normal = {
  ["<leader>"] = {
    -- debug,
    d = {
      name = "debug",
      v = { "<cmd>DapVirtualTextToggle<CR>", "dap virtual txt toggle" },
      d = { function()
        require("dapui").float_element("repl", {
          width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
          height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
          enter = true,
          position = "center",
        })
      end, "debug console" },
      t = { function()
        require("dapui").float_element("console", {
          width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
          height = math.floor(vim.api.nvim_win_get_height(0) * 0.8),
          enter = true,
          position = "center",
        })
      end, "debug terminal" },
      s = { function()
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


return M
