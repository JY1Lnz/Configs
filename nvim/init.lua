--- lazy.nvim start

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
local plugins = require("plugins")

require("lazy").setup({
  plugins,
})

--- lazy.nvim end

require("basic")
require("colorscheme")
require("mappings").setup()
require("lsp/handlers").setup()

local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

vim.cmd([[
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup='Visual', timeout=300}
  ]])

local vim_config = function ()
  vim.cmd([[
    augroup OpenCLFileType
      autocmd!
      autocmd BufRead,BufNewFile *.cl setlocal filetype=cpp
    augroup END
  ]])
  vim.cmd([[
    au BufRead,BufNewFile *.ll set filetype=llvm
  ]])
  vim.cmd([[
    au BufNewFile,BufRead *.td set filetype=tablegen
  ]])
  vim.cmd([[
    au BufNewFile,BufRead *.inc set filetype=cpp
  ]])
end


-- 放在前面会被覆盖，只能丢在这了

local dap_breakpoint = {
    error = {
      text = "",
      texthl = "DapBreakpointText",
      linehl = "DapBreakpointLine",
      numhl = "DapBreakpointNum",
    },
    condition = {
        text = '',
        texthl = 'DapBreakpointText',
        linehl = 'DapBreakpointLine',
        numhl = 'DapBreakpointNum',
    },
    rejected = {
      text = "",
      texthl = "DapBreakpointText",
      linehl = "DapBreakpointLine",
      numhl = "DapBreakpointNum",
    },
    logpoint = {
        text = '',
        texthl = 'DapLogPointText',
        linehl = 'DapLogPointLine',
        numhl = 'DapLogPointNum',
    },
    stopped = {
        text = '',
        texthl = 'DapStoppedText',
        linehl = 'DapStoppedLine',
        numhl = 'DapStoppedNum',
    },
}

vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)

local dap_breakpoint_color = {
    breakpoint = {
        ctermbg=0,
        fg='#d02500',
        -- bg='#31353f',
    },
    logpoing = {
        ctermbg=0,
        fg='#61afef',
        bg='#31353f',
    },
    stopped_line = {
        ctermbg=0,
        fg='#1a1f1b',
        bg='#9ef8b2'
    },
    stopped_text = {
      ctermbg = 0,
      fg='#9ef8b2'
  }
}

vim.api.nvim_set_hl(0, 'DapBreakpointText', dap_breakpoint_color.breakpoint)
vim.api.nvim_set_hl(0, 'DapLogPoint', dap_breakpoint_color.logpoing)
vim.api.nvim_set_hl(0, 'DapStoppedLine', dap_breakpoint_color.stopped_line)
vim.api.nvim_set_hl(0, 'DapStoppedText', dap_breakpoint_color.stopped_text)

vim_config()


require("highlight")
require("custom_function")
-- require("local")
require("tools")


vim.api.nvim_set_hl(0, "NvimTreeNormal", { guibg=NONE, ctermbg=NONE} )
vim.api.nvim_set_hl(0, "NormalFloat", { guibg=NONE, ctermbg=NONE} )
vim.api.nvim_set_hl(0, "WhichKeyFloat", { guibg=NONE, ctermbg=NONE} )
-- transparent
local set_border_transparent = function (group)
  vim.api.nvim_set_hl(0, group, { guibg=NONE, ctermbg=NONE, fg='#ffffff' })
end
local borders = {
  "TelescopeBorder",
  "FloatBorder",
  "SagaBorder",
  "RenameBorder",
  "WhichKeyBorder",
  "NoiceConfirmBorder",
  "NoicePopupmenuBorder",
  "DiagnosticShowBorder",
  "ActionPreviewBorder",
  "NoiceCmdlinePopupBorderCmdline",
  "NoiceCmdlinePopupBorderInput",
  "NoiceCmdlinePopupBorderLua",
  "NoiceCmdlinePopupBorderSearch",
  "NoiceCmdlinePopupBorderFilter",
  "NoiceCmdlinePopupBorderCalculator",
  "NoiceCmdlinePopupBorder",
  "NoiceCmdlinePopupBorderHelper",
}

for k, v in pairs(borders) do
  set_border_transparent(v)
end

vim.api.nvim_set_hl(0, "@comment", { fg="#00bf00" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg='#fff3b7'})
