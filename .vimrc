set nocompatible " disables vi compatibility
syntax enable " enables syntax highlighting
filetype plugin on " allows filetype script to detect file type and enables plugins only used with a specific type of file
" set path+=** " find into all directories and sub directories
set wildmenu " Enables menu autocompletion

packloadall " Loads all plugins
silent! helptags ALL " Loads help files for all plugins

" Install vim-plug if it's not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.github.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" call list of plugins
call plug#begin()
Plug 'vim-scripts/symfony'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jbgutierrez/vim-better-comments'
Plug 'dense-analysis/ale'
" vimgitgutter
call plug#end()

" MAPPING -------------------------------------------------------------------------------------------

let mapleader = " " " Map the leader key to a comma
let maplocalleader = "," " Map the leader key to a comma

" Sets jj to perform Esc input
inoremap jj <esc>
cnoremap jj <esc>

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" command-line window by default
nnoremap : q:i
" search history window by default
nnoremap / q/i

" copy cut paste outside vim


" ctrl d to edit current word
noremap <c-d> viw
inoremap <c-d> <esc>viw

" space to run macros
noremap <leader>j @j

" visual block mode shortcut
nnoremap <c-v> v<c-v>

" edit
nnoremap <c-e> q:ie<space>

" buffer
nnoremap <c-b> q:ib<space>

" tab to autocomplete
inoremap <tab> <c-n>
inoremap <c-f> <c-x><c-f>
inoremap <expr> <CR> pumvisible() ? "\<C-x><C-f>" : "\<CR>"

" join lines
nnoremap gj J

" J to go one paragraph down
noremap J }
" k to go one paragraph up
noremap K {

" L to go to the end of the line
noremap L $
" H to go to the beginning of the line
noremap H ^

" marks
noremap ma mA
noremap 'a `A

" ALE toggle
nnoremap ge :ALEEnable<cr>
nnoremap gE :ALEDisable<cr>

" Remove highlighting after searching
nnoremap <f3> :noh <cr>
inoremap <f3> jj:noh<cr>a

" Enables mouse scrolling up
nnoremap <SrollWheelUp> <c-Y>
" Enables mouse scrolling down
nnoremap <SrollWheelDown> <c-E>

" open vimrc and source it
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" toggle list option
nnoremap <leader>l :set list!<cr>

" ABBREVIATIONS " -------------------------------------------------------------------------------------------

abbrev btw by the way

" imap pf <Esc>:-1read /home/porco/printf<CR>>>f"a
augroup cmappings
	autocmd!
	autocmd FileType c inoremap <buffer> pf printf("");<esc>F"i
augroup END

" AUTOCOMMANDS " -------------------------------------------------------------------------------------------

" remove eol whitespaces automatically
augroup whitespaceRemove
	autocmd!
	autocmd BufLeave * %s/\s\+$//e
augroup END

" indent file before saving
augroup indentScript
	autocmd!
	autocmd BufLeave *.c,*.sh,*.bash,*.vimrc normal! gg=G
augroup END

" save and run file
augroup saveAndRun
	autocmd!
	autocmd FileType sh nnoremap <buffer> <c-l> :w<cr>:!clear; ./%<cr>
	autocmd FileType c nnoremap <buffer> <c-l> :w<cr>:!clear; cfile="%"; execfile=${cfile\%.c}; gcc -g -Wall $cfile -o $execfile && ./$execfile<cr>
augroup END

" COLORS " -------------------------------------------------------------------------------------------

colorscheme symfony
" Changing some symfony defaults
highlight Normal ctermbg=none
highlight LineNr ctermbg=none ctermfg=7
highlight SignColumn ctermbg=none ctermfg=7
highlight Statement ctermbg=none
highlight NonText ctermbg=none
highlight Pmenu ctermfg=15 ctermbg=none
highlight PmenuSel ctermfg=0 ctermbg=15
highlight PmenuSbar ctermfg=15 ctermbg=none
syntax match YellowHeader /^######.*/ contained
highlight link YellowHeader Special
highlight Search ctermbg=255
highlight VertSplit ctermbg=0 ctermfg=0 cterm=none

" airline theme
let g:airline_theme="serene"

" ALE
highlight ALEError ctermbg=none
highlight ALEErrorSign ctermfg=9
highlight ALEWarning ctermbg=none
highlight ALEWarningSign ctermfg=11
highlight ALEInfo ctermbg=none
highlight ALEInfoSign ctermfg=15
" Error, Info, and Warning are the three syntax note types
" ALEError is the error text
" ALEErrorLine is the error whole line
" ALEErrorSign is the SignColumn part
let g:ale_virtualtext_cursor=0
let g:ale_virtualtext=0

" CONFIG " ------------------------------------------------------------------------------------------

set number " Displays line numbers
set wrap " Wraps text
set listchars=tab:>-,trail:O,eol:$,space:⋅,nbsp:+,extends:>,precedes:< " debug empty characters
set fillchars=eob:\ ,vert:\ ,fold:\ ,foldopen:▾,foldsep:│,diff:~
set laststatus=2 " Always display a status line (it gets hidden sometimes otherwise).
set showcmd " Show last command in the status line.
set title " Updates window title
set noruler " Hides cursor position
set scrolloff=5 " Sets lines number until edge before scrolling
set ignorecase " Case not sensitive on searching
set smartcase " Case sensitive on searching if capital is input
set hlsearch " highlight search results
set incsearch " highlight search results during input
let loaded_matchparen=0 " Disables matching brackets highlighting
filetype on " Enables file type detection
set tabstop=2 "	Number of spaces tab is counted for.
set cindent " Enables auto indent
set shiftwidth=2 " Number of spaces to use for autoindent.
set noexpandtab " Tabs are not collections of spaces
set mouse=a " Enables mouse control
set foldmethod=indent " Sets indentation folding
" Keeps folds open by default
autocmd BufRead * normal zR
