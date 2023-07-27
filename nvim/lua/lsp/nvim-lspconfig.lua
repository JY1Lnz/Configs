local lspconfig = require("lspconfig")
local handler = require("lsp/handlers")

local on_attach = function(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig.clangd.setup({
  on_attach = handler.on_attach,
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
    -- 指定clang-tidy的检查参数， 摘抄自cmu15445. 全部参数可参考 https://clang.llvm.org/extra/clang-tidy/checks
    "--clang-tidy-checks=bugprone-*, clang-analyzer-*, google-*, modernize-*, performance-*, portability-*, readability-*, -bugprone-too-small-loop-variable, -clang-analyzer-cplusplus.NewDelete, -clang-analyzer-cplusplus.NewDeleteLeaks, -modernize-use-nodiscard, -modernize-avoid-c-arrays, -readability-magic-numbers, -bugprone-branch-clone, -bugprone-signed-char-misuse, -bugprone-unhandled-self-assignment, -clang-diagnostic-implicit-int-float-conversion, -modernize-use-auto, -modernize-use-trailing-return-type, -readability-convert-member-functions-to-static, -readability-make-member-function-const, -readability-qualified-auto, -readability-redundant-access-specifiers,",
    "--pch-storage=memory",
    "--cross-file-rename=true",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
    -- "--function-arg-placeholders=false",
    -- "--log=verbose",
    -- "--ranking-model=decision_forest",
    -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
  },
  filetypes = {
    "c", "cpp", "objc", "cl", "cuda",
  },
  single_file_support = true,
  root_dir = lspconfig.util.root_pattern('.git', '.clang-tidy', '.conag-format', 'compile_commands.json'),
})

lspconfig.lua_ls.setup {
  on_attach = function()
    on_attach()
  end,
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
