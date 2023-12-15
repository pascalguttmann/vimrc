" GENERAL ---------------------------------------------------------------- {{{

" Add home runtimepath for gvim
set runtimepath-=~/vimfiles
set runtimepath^=~/.vim
set runtimepath-=~/vimfiles/after
set runtimepath+=~/.vim/after

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number
set relativenumber

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase
set smartcase

" Use spellcheck
set spell spelllang=en_us,de_20

" textwidth and colorcolumn
set textwidth=100
set colorcolumn=+0,-8

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=100

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Folding
" Foldingmethod eg. 'syntax' or 'indent'
set foldmethod=indent
" Open files without folds
set nofoldenable

" Backspace behavior
set backspace=indent,eol,start

" }}}


" PLUGINS ---------------------------------------------------------------- {{{

" :PlugInstall to install plugins
" specify plugins by github 'username/plugin-name'
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
    Plug 'dense-analysis/ale'
call plug#end()

" ale configuration
let b:ale_linters = {
\   'plaintex': ['chktex'],
\}

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Set the mapleader
nnoremap <Space> <nop>
let mapleader = " "

" Escape with jj from insert mode
inoremap jj <esc>

" write file
nnoremap <leader>w :w<CR>

" toggle code folding with space
nnoremap <leader><Space> za

" no higlight with leader-slash in normal mode
nnoremap <leader>/ :noh<CR>

" cycle buffers with leader n/N
nnoremap <leader>n :bn<CR>
nnoremap <leader>N :bN<CR>

" go to and correct words from spellcheck
nnoremap <leader>s ]sz=
nnoremap <leader>S [sz=

" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w><
noremap <c-right> <c-w>>

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding in vim files.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    "autocmd FileType vim setlocal foldmarker={{{,}}}
augroup END

augroup f2_build
    autocmd!
    autocmd FileType python nnoremap <buffer> <F2> :w<CR> :!py %<CR>
    autocmd FileType python inoremap <buffer> <F2> <Esc>:w<CR> :!py %<CR>
    autocmd FileType vim nnoremap <buffer> <F2> :w<CR> :so %<CR>
    autocmd BufNewFile,BufRead *.tex
                \ nnoremap <buffer> <F2> :w<CR> :!latexmk -pdf main.tex<CR>
augroup END

augroup f3_func
    autocmd!
    autocmd FileType python nnoremap <buffer> <F3> :w<CR> :!py<CR>
    autocmd FileType python inoremap <buffer> <F3> <Esc>:w<CR> :!py<CR>
augroup END

augroup f4_clean
    autocmd!
    autocmd BufNewFile,BufRead *.tex
                \ nnoremap <buffer> <F4> :!del main.aux main.bbl main.bcf main.blg
                \ main.fdb_latexmk main.fls main.log main.run.xml main.pdf
augroup END

augroup f5_debug
    autocmd!
    autocmd FileType python nnoremap <buffer> <F5> :w<CR> :!py -m pdb %<CR>
    autocmd FileType python inoremap <buffer> <F5> <Esc>:w<CR> :!py -m pdb %<CR>
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END


" If GUI version of Vim is running set these options.
if has('gui_running')

    " Set the background tone.
    set background=dark

    " Set the color scheme.
    colorscheme molokai

    " Set a custom font you have installed on your computer.
    if has("gui_running")
      if has("gui_gtk2")
        set guifont=Inconsolata\ 12
      elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
      elseif has("gui_win32")
        set guifont=Cascadia_Mono:h14:cANSI
      endif
    endif

    " Display more of the file by default.
    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the right-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

endif

" colorcolumn color definition
highlight ColorColumn ctermbg=8 guibg=grey30

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R\ %{getcwd()}

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ (0x%B)\ r%l\ c%c\ (%p%%)

" Show the status on the second to last line.
set laststatus=2

" }}}

