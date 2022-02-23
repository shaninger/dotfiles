local opts = { noremap = true, silent = true}
--local iopts = { inoremap = true }
local term_opts = {silent = true}
local keymap = vim.api.nvim_set_keymap
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-f>", "<cmd>lua require('fzf-lua').files()<CR>", opts)
--keymap("n", "jj", "<esc>", iopts)
vim.cmd "inoremap jj <esc>"
