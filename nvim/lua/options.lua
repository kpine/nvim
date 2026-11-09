-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Tabs and indentation defaults
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- Folds (treesitter sets foldexpr per buffer in plugin/treesitter.lua)
vim.o.foldlevel = 99 -- start with all folds open

-- Search
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.smartcase = true
vim.o.wrapscan = false

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Undo and swap
vim.o.backup = false
vim.o.swapfile = false
vim.o.undofile = true

-- Display
vim.g.netrw_banner = 0
vim.o.breakindent = true
vim.o.cmdheight = 0
vim.o.confirm = true
vim.o.cursorline = true
vim.o.laststatus = 3
vim.o.scrolloff = 10
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.wrap = false
vim.opt.shortmess:append("I")

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Completions
vim.o.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess:append("c")

-- Mouse
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
