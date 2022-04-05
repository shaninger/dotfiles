local folder="build" 
vim.cmd ("set makeprg=mold\\ -run\\ ninja\\ -C\\ " .. folder)
local opts = { noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap
keymap("n", "<C-B>", ":make!<CR>", opts)
keymap("n", "<C-X>", "<cmd>!./" .. folder .. "/bin/ImFusionSuite<CR>", opts)

