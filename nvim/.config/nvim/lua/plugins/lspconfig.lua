return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable('clangd')
    vim.lsp.enable('lua_ls')
    -- lsp handler
    local signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
      -- disable virtual text
      virtual_text = true,
      -- show signs
      signs = {
        active = signs,
        text = {
          [vim.diagnostic.severity.ERROR] = "A",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "",
          [vim.diagnostic.severity.INFO] = "",
        },
        -- linehl = {
        --   [vim.diagnostic.severity.ERROR] = "Error",
        --   [vim.diagnostic.severity.WARN] = "Warn",
        --   [vim.diagnostic.severity.INFO] = "Info",
        --   [vim.diagnostic.severity.HINT] = "Hint",
        -- },
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }

    vim.diagnostic.config(config)
  end
}
