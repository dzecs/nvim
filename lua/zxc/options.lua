-- :help options
-- config.lua
-- Tab configs
local o = vim.opt

o.expandtab = false -- Default
o.tabstop = 2 -- Number of spaces in the bad
o.shiftwidth = 0 -- Uses the value of tabstop
o.softtabstop = 0 -- Default
o.smarttab = true -- Optional
o.smartindent = true -- Make indenting smart again
o.conceallevel = 0 -- So that `` is visible in markdown files
o.fileencoding = "utf-8"
o.hlsearch = false --Set highlight on search
o.splitbelow = true
o.splitright = true
o.cmdheight = 2
o.termguicolors = true

--Make line numbers default
o.number = true
o.relativenumber = true
o.scrolloff = 8

--Enable text wrapping
o.wrap = true

--Enable mouse mode
o.mouse = "a"

--Enable break indent
o.breakindent = true

--Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

--Decrease update time
o.updatetime = 250
o.signcolumn = "yes"

-- System Clipboard
o.clipboard = "unnamedplus"

--File backup settings
o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = os.getenv("HOME") .. "/.config/nvim/.undo"

-- Set completeopt to have a better completion experience
o.completeopt = { "menu", "menuone", "noselect" }

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])
