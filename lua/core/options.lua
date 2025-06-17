local opt = vim.opt
local g = vim.g

--for faster loading
vim.loader.enable()

--for sessions restoring (plugin)
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Wrapping & Scrolling
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = "split"
opt.hlsearch = false

-- Cursor & UI
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.guicursor = ""
opt.background = "dark"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- File Handling
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.backspace = { "start", "eol", "indent" }

-- Performance
opt.updatetime = 50
opt.timeoutlen = 500

-- Folding (for use with nvim-ufo)
opt.foldenable = true
opt.foldmethod = "manual"
opt.foldlevel = 99
opt.foldcolumn = "0"

-- Clipboard
opt.clipboard = "unnamedplus"
-- Mouse support
opt.mouse = "a"
opt.isfname:append("@-@")

-- Disable netrw banner
g.netrw_banner = 0

-- EditorConfig support (if using .editorconfig files)
g.editorconfig = true
