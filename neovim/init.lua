require "user.options"
require "user.plugins"
require "user.cmp"
require "user.lsp"
require "user.gitsigns"
require "user.bufferline"
require "user.autopairs"
require "user.nvim-tree"
require "user.keymap"
require "user.telescope"
require "user.debugger"

-- set local config for cpp project
curdir=vim.fn.getcwd()
if curdir == "/home/haninger/imfusion/suite/plugins" then
 require "imfusioncpp"
end
vim.cmd "colorscheme darcula"
