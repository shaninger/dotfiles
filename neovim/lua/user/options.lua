vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true	-- current line is highlighted
vim.opt.listchars = "tab:→ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:·"
vim.opt.expandtab = false	-- use whitespaces for tab 
vim.opt.foldmethod = "syntax"	-- language specific fold
vim.opt.foldenable = false	-- fold is enabled when opening file
vim.opt.ignorecase = true	-- ignore the case of the letters for searches
vim.opt.smartcase = true	-- if uppercase letter in search -> switch to case sensitive
-- vim.cmd "set list" -- running vim script
