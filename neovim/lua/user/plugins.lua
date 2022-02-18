local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.startup(function(use)
use "wbthomason/packer.nvim"
use "nvim-lua/popup.nvim"
use "nvim-lua/plenary.nvim"
use {'dracula/vim', as = 'dracula'}
-- use {'doums/darcula', as = 'dracula'}
use "hrsh7th/nvim-cmp"
use "neovim/nvim-lspconfig"
-- use "williamboman/nvim-lsp-installer"
end)

