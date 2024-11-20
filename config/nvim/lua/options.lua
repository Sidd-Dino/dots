vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

vim.opt.updatetime = 50
vim.opt.timeoutlen = 200

vim.opt.mouse = 'a'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes"

vim.opt.cursorline = true
vim.opt.wrap = false

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.inccommand = "split"

-- Options made redundant by tpope/vim-sleuth
-- vim.opt.shiftwidth = 4
-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.expandtab = true

vim.opt.breakindent = true
vim.opt.smartindent = true

-- better window spliting behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"
vim.opt.undofile = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
--vim.opt.listchars:append "eol:↵"

--vim.opt.shortmess:append "sI" -- disable nvim intro
--vim.opt.whichwrap:append "<>[]hl"
