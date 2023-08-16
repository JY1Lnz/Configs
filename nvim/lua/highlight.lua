vim.api.nvim_exec([[ hi link @lsp.type.method Method]], true)
vim.api.nvim_exec([[ hi link @lsp.type.parameter Parameter]], true)
vim.api.nvim_exec([[ hi link @lsp.type.property Property]], true)
vim.api.nvim_exec([[ hi link @lsp.type.namespace Namespace]], true)
vim.api.nvim_exec([[ hi @lsp.type.enum guifg=#3084B4 gui=bold]], true)
vim.api.nvim_exec([[ hi @lsp.type.enumMember guifg=#00E2C8 gui=bold]], true)
vim.api.nvim_exec([[ hi rainbowcol1 guifg=#BDB76B ]], true)
vim.api.nvim_exec([[ hi @lsp.mod.readonly.cpp gui=bold ]], true)
vim.api.nvim_exec([[ hi @lsp.mod.static.cpp gui=underline,bold ]], true)

vim.api.nvim_exec([[
  augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
  augroup END
]], true)
