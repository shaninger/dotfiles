set exrc " execute .vimrc of current directory
set secure " limit the execution possibilities of other .vimrc's
set number " show line numbers
set relativenumber " show relative line numbers
set ignorecase " ignores case of search
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:· " set list characters, turn on in vim with ':set list'

" manage tabs
"---------------------------------------
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
"---------------------------------------
	
" remap escape to jj
inoremap jj <esc>

" install vim-plug with:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/vim/plugged') " install plugins with :PlugInstall in vim
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree' " activate with ':NERDTree' in vim
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" gruvbox settings
autocmd vimenter * colorscheme gruvbox " setting for gruvbox as default

set bg=dark " sets the background to dark mode, since in some terminals it is bright

" settings for lightline 
set laststatus=2 " statusbar to appear
set noshowmode " not show -- INSERT -- line

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
