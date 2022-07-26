let s:is_win = has('win32')
if s:is_win
  set shell=cmd.exe
  set shellcmdflag=/c
endif

if has('termguicolors')
  set termguicolors
endif

language en_US             " Force english language

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.
set smartcase

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set nowrap

set laststatus=3           " global status line

set list                   " Show trailing spaces, tabs and non breakable spaces
set listchars=trail:~,tab:>-,nbsp:␣

set clipboard+=unnamedplus " system clipboard

" Put all temporary files under the same directory.
set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap/
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo

" plugins
call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/which-key.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
call plug#end()

let mapleader = " "

" theme (plugin needed)
set background=dark
colorscheme gruvbox

" line numbers
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" buffer switch
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
