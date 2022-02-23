local folder="cmake-build-relwithdebinfo-ml" 
vim.cmd ("set makeprg=make\\ -C\\ " .. folder .. "\\ -j12")
local opts = { noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap
keymap("n", "<C-B>", ":make!<CR>", opts)
keymap("n", "<C-R>", "<cmd>!./" .. folder .. "/bin/ImFusionSuite<CR>", opts)
