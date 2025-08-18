-- basic config
-- vim.g.{name} 	: global variable
-- vim.b.{name} 	: buffer variable
-- vim.w.{name} 	: window variable
-- vim.bo.{option} 	: buffer-local option
-- vim.wo.{option} 	: window-local option

-- utf-8
vim.g.encoding = "UTF-8"
vim.g.fileencoding = "utf-8"

-- hjkl move save line
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- relative number line
vim.wo.number = true
vim.wo.relativenumber = true

-- highlight cursor line
vim.wo.cursorline = true
vim.wo.cursorcolumn = true

-- left sidebar icon
vim.wo.signcolumn = "yes"

-- right code line
vim.wo.colorcolumn = "81"

-- indent
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true

-- << >> length
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2

-- space to tab
vim.o.expandtab = true
vim.bo.expandtab = true

-- new line
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- serach 
vim.o.ignorecase = true
vim.o.smartcase = true
-- vim.o.hlsearch = false
vim.o.incsearch = true

-- cmd line height
-- vim.o.cmdheight = 2

-- auto load chang file
vim.o.autoread = true
vim.bo.autoread = true

-- dont wrap line
vim.wo.wrap = true

vim.o.mouse = "a"

-- dont create swap file
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

vim.o.splitbelow = true
vim.o.splitright = true

-- cmp
vim.g.completeopt = "menu,menuone,noselect,noinsert"

vim.o.list = true
vim.o.listchars = "space:·"

-- nvim-tree
vim.opt.termguicolors = true

vim.opt.exrc = true

-- grep
vim.o.grepprg = "rg --vimgrep --smart-case --hidden"
vim.o.grepformat = "%f:%l:%c:%m"

