set exrc
set nocompatible
set encoding=utf-8
set number
syntax on
set cursorline
set t_Co=256
set relativenumber
set incsearch
set linebreak
set noswapfile
let mapleader = " "
set nowrap
set signcolumn=yes
set colorcolumn=80

filetype plugin on
filetype indent on 

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Keycode delay solution
set timeoutlen=1000
set ttimeoutlen=50

set mouse=n
set belloff=all

set showtabline=2

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

if exists('+termguicolors')  
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Access colors present in 256 colorspace
let base16colorspace=256

" Custom syntax highlight for C
au Syntax c	source $VIMRUNTIME/syntax/c.vim
let g:c_syntax_for_h = 1 " All header files are treated as only C files with this

" Pluggins 
call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'

Plug 'morhetz/gruvbox'
Plug 'chriskempson/vim-tomorrow-theme'

Plug 'suan/vim-instant-markdown', {'for':'markdown'}

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'Eric-Song-Nop/vim-glslx'

Plug 'sakshamgupta05/vim-todo-highlight'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


"  Glsl : setting color scheme
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glslx

" Setting the colorscheme and the background color
"let g:gruvbox_contrast_dark = 'hard'
"colorscheme gruvbox
"set background=dark
colorscheme Tomorrow-Night-Bright

" Source vimrc
noremap <leader>v :so $MYVIMRC<CR>


" Remaped the jumps bw splited windows 
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Delete a buffer without closing the split window
nnoremap <silent> <leader>d :bp\|bd #<CR>

" Jumping between buffers
nnoremap <leader>. :bn<CR>
nnoremap <leader>, :bp<CR>
" Jumping between tabs
"nnoremap <leader>. :tabn<CR>
"nnoremap <leader>, :tabp<CR>

" nerdcommenter commenting  
map <leader>/ <plug>NERDCommenterToggle

" vimwiki
map <leader>md :InstantMarkdownPreview<CR>
let g:vimwiki_ext2syntax = {'.md':'markdown','.markdown':'markdown','.mdown':'markdown'} "markdown support
let g:instant_markdown_autostart = 0 " disable autostart 

" Opening explorer page on the same pane
nnoremap <leader>m :Ex<CR>
" Explore page on a new pane
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" Undotree
nnoremap <leader>u :UndotreeShow<CR>

" Resizing window pane 
nnoremap <silent> <leader>= :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

"-----------------------------------------------------------------------------
" Nerdtree
"-----------------------------------------------------------------------------

nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <leader><> :NERDTree<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Start NERDTree when Vim is opened and leave the cursor in it.
autocmd VimEnter * NERDTree

" Start NERDTree when Vim is opened and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p


" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif



"-----------------------------------------------------------------------------
" vim todo highlight
"-----------------------------------------------------------------------------

"\'gui_bg_color': '#1d2021' 
let g:todo_highlight_config = {
        \'FIXME': {
            \'gui_bg_color': '#ff3300',
            \'gui_fg_color': '#ffffff'
        \},
        \'TODO': {
            \'gui_bg_color': '#ff6600',
            \'gui_fg_color': '#ffffff'
        \},
        \'NOTE': {
            \'gui_bg_color' : '#00ffff',
            \'gui_fg_color': '#000000'
        \}
    \}

" FIXME:
" NOTE:
" TODO: dkfjdkfj
" NOTE(hell):

" -----------------------------------------------------------------------------
" Airline
" -----------------------------------------------------------------------------

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#righ_alt_sep = '|'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.colnr = ':'
let g:airline_symbols.colnr = ':'
let g:airline_symbols.crypt = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.spell = ''
let g:airline_symbols.notexists = ''
let g:airline_symbols.whitespace = ''

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.dirty=''


" Includes the lua/lsp.lua file
lua require('lspsetup')

"lua require('telescope')
"fzf.vim plugin
nnoremap <leader>s :Files<CR>
