local Terminal = require("toggleterm.terminal").Terminal
require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  }
})

local lisp_terminal = Terminal:new({
  cmd = "racket",
  hidden = true,
  direction = "horizontal",
  name = "lisp",
})

vim.api.nvim_create_user_command("LispT", function ()
  lisp_terminal:toggle()
end, {})

vim.api.nvim_create_user_command("Lisp", function ()
  file = vim.api.nvim_buf_get_name(0)
  if not lisp_terminal:is_open() then
    lisp_terminal:toggle()
  end
  cmd = '(enter! (file "'..file..'"))'
  cmd = lisp_terminal.id.."TermExec cmd='"..cmd.."'"
  vim.api.nvim_command(cmd)
end, {})
