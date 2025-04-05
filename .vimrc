set nocompatible " disables vi compatibility
syntax enable " enables syntax highlighting
filetype plugin on " allows filetype script to detect file type and enables plugins only used with a specific type of file
set path+=** " find into all directories and sub directories

set wildmenu " Enables menu autocompletion
set wildmode=list:longest,full

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
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jbgutierrez/vim-better-comments'
Plug 'dense-analysis/ale'
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdtree'
call plug#end()

" MAPPING -------------------------------------------------------------------------------------------

let mapleader = " " " Map the leader key to a comma
" cancel space bar default behavior
nnoremap <space> <nop>
vnoremap <space> <nop>
onoremap <space> <nop>

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

" escape to get out of command-line window
autocmd CmdwinEnter * nnoremap <esc> o<cr>

" search history window by default
nnoremap / q/i
nnoremap ? q?i

" switch to previous and next buffer
nnoremap - :bprevious<cr>
nnoremap + :bnext<cr>

" NERDTree
nnoremap <c-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

" ctrlp
let g:ctrlp_show_hidden=1

" copy cut paste outside vim


" ctrl d to edit current word
noremap <c-d> viw
inoremap <c-d> <esc>viw

" space to run macros
noremap <leader>j @j

" visual block mode shortcut
nnoremap <c-v> v<c-v>

" edit
" nnoremap <c-e> q:ie<space>

" buffer
nnoremap <c-b> q:ib<space>

" join lines
nnoremap gj J

" J to go down faster
noremap J 20j
" k to go up faster
noremap K 20k

" L to go to the end of the line
noremap L $l
nnoremap yL y$
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
inoremap <f3> <esc>:noh<cr>a

" Enables mouse scrolling up
nnoremap <SrollWheelUp> <c-Y>
" Enables mouse scrolling down
nnoremap <SrollWheelDown> <c-E>

" open vimrc and source it
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :w<cr>:source $MYVIMRC<cr>

" open bashrc
nnoremap <leader>eb :vsplit ~/.bashrc<cr>

" toggle list option
nnoremap <leader>l :set list!<cr>

" autocomplete
inoremap <tab> <c-n>
inoremap <s-tab> <c-p>
inoremap <c-f> <c-x><c-f>
set shortmess+=c " remove pattern not found message
inoremap / /<c-x><c-f><c-p>
inoremap ~ ~<c-x><c-f><c-p>
inoremap . .<c-x><c-f><c-p>
inoremap a a<c-n><c-p>
inoremap b b<c-n><c-p>
inoremap c c<c-n><c-p>
inoremap d d<c-n><c-p>
inoremap e e<c-n><c-p>
inoremap f f<c-n><c-p>
inoremap g g<c-n><c-p>
inoremap h h<c-n><c-p>
inoremap i i<c-n><c-p>
inoremap j j<c-n><c-p>
inoremap k k<c-n><c-p>
inoremap l l<c-n><c-p>
inoremap m m<c-n><c-p>
inoremap n n<c-n><c-p>
inoremap o o<c-n><c-p>
inoremap p p<c-n><c-p>
" inoremap q q<c-n><c-p>
inoremap r r<c-n><c-p>
inoremap s s<c-n><c-p>
inoremap t t<c-n><c-p>
inoremap u u<c-n><c-p>
inoremap v v<c-n><c-p>
" inoremap w w<c-n><c-p>
inoremap x x<c-n><c-p>
inoremap y y<c-n><c-p>
inoremap z z<c-n><c-p>
inoremap A A<c-n><c-p>
inoremap B B<c-n><c-p>
inoremap C C<c-n><c-p>
inoremap D D<c-n><c-p>
inoremap E E<c-n><c-p>
inoremap F F<c-n><c-p>
inoremap G G<c-n><c-p>
inoremap H H<c-n><c-p>
inoremap I I<c-n><c-p>
inoremap J J<c-n><c-p>
inoremap K K<c-n><c-p>
inoremap L L<c-n><c-p>
inoremap M M<c-n><c-p>
inoremap N N<c-n><c-p>
inoremap O O<c-n><c-p>
inoremap P P<c-n><c-p>
inoremap Q Q<c-n><c-p>
inoremap R R<c-n><c-p>
inoremap S S<c-n><c-p>
inoremap T T<c-n><c-p>
inoremap U U<c-n><c-p>
inoremap V V<c-n><c-p>
inoremap W W<c-n><c-p>
inoremap X X<c-n><c-p>
inoremap Y Y<c-n><c-p>
inoremap Z Z<c-n><c-p>

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
	autocmd BufLeave *.c,*.sh,*.bash*,*.vimrc,*.txt if &modifiable | %s/\s\+$//e | endif
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
let g:ctrl_show_hidden=1 " show hidden files in ctrlp plugin
set virtualedit=onemore " add onw virtual space to the end of the line
