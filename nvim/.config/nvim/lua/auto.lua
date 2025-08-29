-- Run command
-- lsp enable

lsp_config = {
  ['clangd'] = {
    'c', 'cpp', 'objc', 'objcpp', 'cuda',
  },
  ['lua_ls'] = {
    'lua',
  },
  ['bashls'] = {
    'bash', 'sh', 'zsh',
  }
}

for lsp_name, pat in pairs(lsp_config) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = pat,
    callback = function()
      print("----lsp " .. lsp_name)
      vim.lsp.enable(lsp_name)
    end
  })
end

-- vim.api.nvim_create_user_command('LspEnable', function(opts)
--   local actio = opts.args
--   local allowedActions = {
--     'clangd', 'lua_ls', 'bashls'
--   }
--
-- end)
