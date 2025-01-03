local lspconfig = require("lspconfig")
local handler = require("lsp/handlers")


local capabilities = vim.lsp.protocol.make_client_capabilities()
local dir = vim.fn.getcwd()
local filepath = dir .. '/build/compile_commands.json'
local filepath_dir = dir .. '/build'

local file_exists = function(filename)
  local file = io.open(filename, "r")
  if file then
    file:close()
    return true
  end
  return false
end

local clangd_cmd = {
  "/Users/jyl/Library/Application Support/Code/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/18.1.3/clangd_18.1.3/bin/clangd",
  "--pretty",
  "--background-index",   -- 后台建立索引，并持久化到disk
  "-j=16",
  "--completion-style=detailed",
  "--clang-tidy",   -- 开启clang-tidy
  -- "--clang-tidy-checks=bugprone-*, clang-analyzer-*, google-*, modernize-*, performance-*, portability-*, readability-*, -bugprone-too-small-loop-variable, -clang-analyzer-cplusplus.NewDelete, -clang-analyzer-cplusplus.NewDeleteLeaks, -modernize-use-nodiscard, -modernize-avoid-c-arrays, -readability-magic-numbers, -bugprone-branch-clone, -bugprone-signed-char-misuse, -bugprone-unhandled-self-assignment, -clang-diagnostic-implicit-int-float-conversion, -modernize-use-auto, -modernize-use-trailing-return-type, -readability-convert-member-functions-to-static, -readability-make-member-function-const, -readability-qualified-auto, -readability-redundant-access-specifiers,",
  "--clang-tidy-checks=llvm-*, llvmlibc-*, clang-analyzer-*, hicpp-*",
  "--pch-storage=memory",
  "--cross-file-rename=true",
  "--header-insertion=iwyu",
  "--header-insertion-decorators",
}

-- if file_exists(filepath) then
--   table.insert(clangd_cmd, "--compile-commands-dir=" .. filepath_dir)
-- end

lspconfig.clangd.setup({
  -- settings = {
  --   InlayHints = {
  --     Enabled = true,
  --     ParameterNames = true,
  --     DeducedTypes = true,
  --   }
  -- },
  on_attach = handler.on_attach,
  flags = {
    debounce_text_change = 150,
  },
  cmd = clangd_cmd,
  filetypes = {
    "c", "cpp", "objc", "cuda",
  },
  single_file_support = true,
  root_dir = lspconfig.util.root_pattern('.git', '.clang-tidy', '.conag-format', 'compile_commands.json', '.clangd'),
})

-- lspconfig.opencl_ls.setup({
--   flag = {
--     debounce_text_change = 150,
--   },
--   cmd = {
--     "opencl-language-server",
--   },
--   single_file_support = true,
--   filetypes = { "opencl", "cl" },
--   root_dir = lspconfig.util.root_pattern('.git', '.clang-tidy', '.conag-format', 'compile_commands.json'),
-- })

lspconfig.lua_ls.setup {
  on_attach = handler.on_attach,
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
  cmd = {
    "/Users/jyl/.local/share/nvim/mason/bin/lua-language-server",
  },
  filetype = {
    "lua",
  },
  root_dir = lspconfig.util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git"),
  single_file_support = true,
}

-- lspconfig.pyright.setup({
--   flags = {
--     debounce_text_change = 150,
--   },
--   cmd = {
--     "pyright-langserver",
--     "--stdio",
--   },
--   filetype = { "python", },
--   single_file_support = true,
--   root_dir = lspconfig.util.root_pattern('.git', '.clang-tidy', '.conag-format', 'compile_commands.json'),
--   settings = {
--     python = {
--       analysis = {
--         autoSearchPaths = true,
--         diagnosticMode = "workspace",
--         useLibraryCodeForTypes = true
--       }
--     }
--   }
-- })

-- vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = "LspAttach_inlayhints",
--   callback = function(args)
--     if not (args.data and args.data.client_id) then
--       return
--     end
--
--     local bufnr = args.buf
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     require("lsp-inlayhints").on_attach(client, bufnr)
--   end,
-- })
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--   callback = function(ev)
--     local buffer = ev.buf
--     handler.on_attach(buffer)
--   end
-- })
