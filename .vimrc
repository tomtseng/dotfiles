" Vundle {{{
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'valloric/MatchTagAlways'
Plugin 'godlygeek/tabular'
Plugin 'sirver/ultisnips'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/vim-peekaboo'
Plugin 'lervag/vimtex'
Plugin 'Valloric/YouCompleteMe'
Plugin 'github/copilot.vim'

call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" UltiSnips settings {{{

" Don't use tab -- it conflicts with YouCompleteMe.
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" }}}

" Vimtex and LaTeX editing settings {{{
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

let g:vimtex_compiler_latexmk = {
  \ 'continuous' : 0,
\}

" Need to have a vim server in order for PDF inverse search to work
if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

" }}}

" YouCompleteMe settings {{{
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/.vim/bundle/YouCompleteMe/cpp/ycm_extra_conf.py']

let g:ycm_enable_semantic_highlighting=1
let g:ycm_enable_inlay_hints=1
" Don't show hover hint (but can still show it manually with <plug>(YCMHover))
let g:ycm_auto_hover=0

" set <leader> to the space bar
let mapleader = "\<Space>"
nnoremap <leader>o <plug>(YCMHover)
nnoremap <leader>gt :YcmCompleter GoTo<CR>
" for when GoTo is too slow
nnoremap <leader>gi :YcmCompleter GoToImprecise<CR>
" prefer GoTo over these, so I use a less convenient keybinding
nnoremap <leader>Gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>Gf :YcmCompleter GoToDefinition<CR>

" end YouCompleteMe settings }}}

" vim-commentary settings
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

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

" Limit time spent on delimiter matching. This matching takes a long time on
" large LaTeX files.
let g:matchparen_timeout = 20  " milliseconds
let g:matchparen_insert_timeout = 20  " milliseconds

" spell check with a hotkey during insert mode to correct the previous mistake
set spell spelllang=en_us
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u

" Allow moving left and right in insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>

set rtp+=~/.fzf

let g:airline#extensions#tabline#enabled = 1

nnoremap Y y$
nnoremap <C-L> :nohl<CR><C-L>
nnoremap <C-p> :FZF<CR>
" remove trailing whitespace
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
vnoremap a= :Tabularize /=<CR>

" moving up and down on wrapped lines works
nnoremap j gj
nnoremap k gk

nnoremap <leader><Space> :cd ..<CR>

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
autocmd FileType python call PYSET()
autocmd FileType make call MAKEFILESET()
autocmd FileType html    call HTMLSET()
" end settings by filetype }}}
