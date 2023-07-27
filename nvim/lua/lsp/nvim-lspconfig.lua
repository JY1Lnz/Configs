local lspconfig = require("lspconfig")
local handler = require("lsp/handlers")

local on_attach = function(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig.clangd.setup({
  flags = {
    debounce_text_change = 150,
  },
  cmd = {
    "clangd",
    "--pretty",
    "--background-index", -- 后台建立索引，并持久化到disk
    "-j=16",
    "--completion-style=detailed",
    "--clang-tidy", -- 开启clang-tidy
    "--clang-tidy-checks=bugprone-*, clang-analyzer-*, google-*, modernize-*, performance-*, portability-*, readability-*, -bugprone-too-small-loop-variable, -clang-analyzer-cplusplus.NewDelete, -clang-analyzer-cplusplus.NewDeleteLeaks, -modernize-use-nodiscard, -modernize-avoid-c-arrays, -readability-magic-numbers, -bugprone-branch-clone, -bugprone-signed-char-misuse, -bugprone-unhandled-self-assignment, -clang-diagnostic-implicit-int-float-conversion, -modernize-use-auto, -modernize-use-trailing-return-type, -readability-convert-member-functions-to-static, -readability-make-member-function-const, -readability-qualified-auto, -readability-redundant-access-specifiers,",
    "--pch-storage=memory",
    "--cross-file-rename=true",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
  },
  filetypes = {
    "c", "cpp", "objc", "cl", "cuda",
  },
  single_file_support = true,
  root_dir = lspconfig.util.root_pattern('.git', '.clang-tidy', '.conag-format', 'compile_commands.json'),
})

lspconfig.lua_ls.setup {
  -- on_attach = handler.on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local buffer = ev.buf
    handler.on_attach(buffer)
  end
})
