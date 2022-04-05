local opts = { noremap = true, silent = true}
--local iopts = { inoremap = true }
local term_opts = {silent = true}
local keymap = vim.api.nvim_set_keymap
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--keymap("n", "<C-f>", "<cmd>lua require('fzf-lua').files()<CR>", opts)
-- buffer shortcuts
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-x>", ":Bdelete<CR>", opts)

-- fuzzy search
keymap("n", "<C-N>", ":Telescope find_files<CR>", opts)
keymap("n", "<C-F>", ":Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "<S-F>", ":Telescope live_grep<CR>", opts)

-- file browser
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- cancel insertion mode
--keymap("n", "jj", "<esc>", iopts)
vim.cmd "inoremap jj <esc>"
