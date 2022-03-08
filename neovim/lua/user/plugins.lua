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

-- colorschemes
use {'dracula/vim', as = 'dracula'}
use {'doums/darcula'}

-- completion
use "hrsh7th/nvim-cmp"
use "hrsh7th/cmp-buffer"
use "hrsh7th/cmp-path"
use "hrsh7th/cmp-nvim-lsp"
use "L3MON4D3/LuaSnip"
use "saadparwaiz1/cmp_luasnip"

-- lsp
use "neovim/nvim-lspconfig"

-- fuzzy search
use { 'junegunn/fzf', run = './install --bin', }
--use { 'ibhagwan/fzf-lua',
  -- optional for icon support
--  requires = { 'kyazdani42/nvim-web-devicons' }
--}
use "junegunn/fzf.vim"
-- use "williamboman/nvim-lsp-installer"
end)

