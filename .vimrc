" Vundle {{{
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'valloric/MatchTagAlways'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on    " required
" }}}

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
filetype indent plugin on

set background=dark
colorscheme jellybeans

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
set lazyredraw
set showmatch
" fix background color in tmux
set t_ut=

set rtp+=~/.fzf

let g:airline#extensions#tabline#enabled = 1

" set <leader> to the space bar
let mapleader = "\<Space>"

nnoremap Y y$
nnoremap <C-L> :nohl<CR><C-L>
nnoremap <C-p> :FZF<CR>
" remove trailing whitespace
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
vnoremap a= :Tabularize /=<CR>

" moving up and down on wrapped lines works
nnoremap j gj
nnoremap k gk

nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>

" Delete buffers not currently shown.
" Copied from https://stackoverflow.com/a/7321131
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()

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
