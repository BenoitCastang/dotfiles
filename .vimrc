set nocompatible " Disables Vi compatibility themes
syntax on " Enables syntax highlighting
filetype plugin on " Enables plugins only used with a specific type of file
set path=~/** " :find into all directories and sub directories
set wildmenu " Enables menu autocompletion

packloadall " Loads all plugins
silent! helptags ALL " Loads help files for all plugins

" Install vim-plug if it's not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.github.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'vim-scripts/symfony'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
" PlugInstall to install all plugins

" Mapping -------------------------------------------------------------------------

let mapleader = "," " Map the leader key to a comma
" Sets jj to perform Esc input
imap jj <Esc>
cmap jj <Esc>
" nmap <C-;> :
" z + o and z + c for opening and closing folds
" :%s/pattern/replacement/gc for substitution with confirmation on all the
" page
" Remove highlighting after searching
nnoremap <F3> :noh <CR>
" Enables mouse scrolling up
noremap <SrollWheelUp> <C-Y> 
" Enables mouse scrolling down
noremap <SrollWheelDown> <C-E> 
" Snippets and abbreviations
" imap pf <Esc>:-1read /home/porco/printf<CR>>>f"a
" ab pf printf("");

" Config ---------------------------------------------------------------------

colorscheme symfony
" Changing some symfony defaults
highlight Normal ctermbg=none
highlight LineNr ctermbg=none ctermfg=7
highlight Statement ctermbg=none
highlight NonText ctermbg=none
highlight Pmenu ctermfg=15 ctermbg=none
highlight PmenuSel ctermfg=0 ctermbg=15
highlight PmenuSbar ctermfg=15 ctermbg=none
syntax match YellowHeader /^######.*/ contained
highlight link YellowHeader Special
" airline theme
let g:airline_theme='serene'
set relativenumber
set laststatus=2 " Always display a status line (it gets hidden sometimes otherwise).
set showcmd " Show last command in the status line.
set title " Updates window title
set number " Displays line numbers
set noruler " Hides cursor position
set wrap " Wraps text
set scrolloff=5 " Sets lines number until edge before scrolling
set ignorecase " Case not sensitive on searching
set smartcase " Case sensitive on searching if capital is input
set hlsearch " Surligne les resultats de recherche
set incsearch " Surligne les resultats de recherche pendant la saisie
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
