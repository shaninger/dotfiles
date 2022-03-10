require "user.options"
require "user.keymap"
require "user.plugins"
require "user.cmp"
require "user.lsp"
require "user.gitsigns"
require "user.bufferline"

-- set local config for cpp project
curdir=vim.fn.getcwd()
-- if curdir == "/home/haninger/imfusion/repos/suite/plugins" then
require "imfusioncpp"
--end
vim.cmd "colorscheme darcula"
