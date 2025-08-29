return {
  "williamboman/mason.nvim",
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonInstallAll",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },
  opts = {
    ensure_installed = {
      "cmake-language-server",
      "clangd",
      "clang-format",
      "codelldb",
      "lua-language-server",
      "pyright",
    }
  },
  config = function(_, opts)
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
    })
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    end, {})
    vim.g.mason_binaries_list = opts.ensure_installed
  end,
}
