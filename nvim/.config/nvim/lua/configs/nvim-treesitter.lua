local nt = require("nvim-treesitter.configs")
nt.setup({
  ensure_installed = {
    "json", "html", "css", "vim", "lua", "javascript", "typescript", "c", "cpp", "python", "lua"
  },
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
    disable = function (lang, buf)
      local max_filesize = 4 * 1024 * 1024
      local ok, status = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and status and status.size > max_filesize then
        return true
      end
    end
  },
  -- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  indent = {
    enable = false,
  },
  rainbow = {
    enable = false,
    extenden_mode = true,
    max_file_liens = nil,
  },
  fold = {
    enable = true,
  },
})

-- 开启 Folding 模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldenable = false
vim.opt.foldlevel = 99

