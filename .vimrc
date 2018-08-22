" Vundle {{{
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'valloric/MatchTagAlways'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" Syntastic settings {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2 " default
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_compiler_options = "-std=c99 -Wall -Wextra -Wpedantic -Wshadow -Wstrict-overflow -fno-strict-aliasing"
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic -Wshadow -Wstrict-overflow -fno-strict-aliasing"
" end Syntastic settings }}}

" delimitMate settings {{{
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END
" end delimitMate settings }}}

" YCM settings {{{
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/.vim/bundle/YouCompleteMe/cpp/ycm_extra_conf.py']
" end YCM settings }}}

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
set noerrorbells visualbell t_vb= " disable bells
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F9>
set history=512 " remember 512 past commands
set guioptions= " removes GUI widgets
set scrolloff=5 " see lines above and below
set wrap
set textwidth=80
set fdm=marker " folding

set shiftwidth=2
set softtabstop=2
set expandtab

map Y y
nnoremap <C-L> :nohl<CR><C-L>
" remove trailing whitespace
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
map <C-n> :NERDTreeToggle<CR>
vmap a= :Tabularize /=<CR>
set rtp+=~/.fzf
" fix background color in tmux
set t_ut=

set lazyredraw
set showmatch

" moving up and down on wrapped lines works
nnoremap j gj
nnoremap k gk

" settings by filetype {{{
function! CSET()
  set makeprg=if\ \[\ -f\ \"Makefile\"\ \];then\ make\ $*;else\ if\ \[\ -f\ \"makefile\"\ \];then\ make\ $*;else\ gcc\ -O2\ -std=c99\ -g\ -Wall\ -W\ -lm\ -o%.bin\ %\ &&\ ./%.bin;fi;fi
  set errorformat=%f:%l:\ %m
endfunction

function! CPPSET()
  set makeprg=if\ \[\ -f\ \"Makefile\"\ \];then\ make\ $*;else\ if\ \[\ -f\ \"makefile\"\ \];then\ make\ $*;else\ g++\ -std=c++11\ -O2\ -g\ -Wall\ -W\ -O2\ -o%.bin\ %\ &&\ ./%.bin;fi;fi
endfunction

function! TEXSET()
  set makeprg=if\ \[\ -f\ \"Makefile\"\ \];then\ make\ $*;else\ if\ \[\ -f\ \"makefile\"\ \];then\ make\ $*;else\ pdflatex\ -file-line-error-style\ %\ &&\ evince\ %:r.pdf;fi;fi
  set errorformat=%f:%l:\ %m
endfunction

function! PYSET()
  set makeprg=if\ \[\ -f\ \"Makefile\"\ \];then\ make\ $*;else\ if\ \[\ -f\ \"makefile\"\ \];then\ make\ $*;else\ python3\ %;fi;fi
endfunction

function! MAKEFILESET()
  set tw=0
  set nowrap
  " in a Makefile we need to use <Tab> to actually produce tabs
  set noet
  set sts=8
endfunction

function! HTMLSET()
  set tw=0
  set nowrap
endfunction

autocmd FileType c call CSET()
autocmd FileType cpp call CSET()
autocmd FileType cc call CSET()
autocmd FileType tex call TEXSET()
autocmd FileType python call PYSET()
autocmd FileType make call MAKEFILESET()
autocmd FileType html    call HTMLSET()
" end settings by filetype }}}
