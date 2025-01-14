set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin()

" avante deps
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

" avante optional deps
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'

Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

call plug#end()

" Use global Python (to use globally installed packages) even in virtualenv.
" related: https://github.com/neovim/neovim/issues/1887#issuecomment-280653872
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog='/Users/t/.pyenv/versions/' . trim(system('cat /Users/t/.pyenv/version')) . '/bin/python'
endif

lua << EOF
require('avante_lib').load()
require('avante').setup({
    -- Put entries here if you'd like to override the default config
})
