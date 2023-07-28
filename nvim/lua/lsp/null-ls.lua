local null_ls = require("null-ls")

local opts = {
  sources = {
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.formatting.clang_format.with({
      extra_args = { "-style=LLVM"},
    }),
  }
}

return opts
