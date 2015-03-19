" Vundle stuff begins here *****
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'valloric/MatchTagAlways'
Plugin 'bling/vim-airline'
"Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
"Plugin 'vim-scripts/a.vim' " commands to quickly switch into header files (.h)
"Plugin 'tpop/vim-fugitive' " git commands from within vim
Plugin 'Raimondi/delimitMate' " insert matching delimiters like parens, etc

call vundle#end()            " required
filetype plugin indent on    " required
" Vundle stuff ends here ******

" Syntastic settings ***
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" end Syntastic settings *******

" delimitMate settings *********
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END
" end delimitMate settings *****

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
