" Vundle stuff begins here *****
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'valloric/MatchTagAlways'
Plugin 'bling/vim-airline'

call vundle#end()            " required
filetype plugin indent on    " required
" Vundle stuff ends here ******

set nocompatible

syntax enable
set background=dark
colorscheme jellybeans

filetype indent plugin on

set hidden
set wildmenu
set showcmd
set hlsearch
set incsearch " immediately start searching as you type

set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set cmdheight=2
set number
set relativenumber
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set history=512 " remember 512 past commands
set guioptions= " removes GUI widgets
set scrolloff=5 " see lines above and below
set wrap
set textwidth=80

set shiftwidth=2
set softtabstop=2
set expandtab

map Y y
nnoremap <C-L> :nohl<CR><C-L>
" remaps ,<space> to turn off hl
nnoremap <leader><space> :nohlsearch

set lazyredraw
set showmatch

nnoremap j gj
nnoremap k gk
