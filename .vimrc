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
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline-themes'
Plug 'jbgutierrez/vim-better-comments'
Plug 'dense-analysis/ale'
call plug#end()
" PlugInstall to install all plugins

" MAPPING -------------------------------------------------------------------------------------------

let mapleader = " " " Map the leader key to a comma

" Sets jj to perform Esc input
imap jj <Esc>
cmap jj <Esc>

" command-line window by default
nmap : q:i
" search history window by default
nmap / q/i

" save and run file
nmap <leader>s :w<CR>:!clear; if [[ "%" =~ .sh$ ]]; then ./%; elif [[ "%" =~ .c$ ]]; then cfile="%"; exfile=${cfile\%.c}; gcc -g -Wall $cfile -o $exfile && ./$exfile; fi<CR>

" visual block mode shortcut
nmap <C-v> v<C-v> 

" wrap lines
nnoremap gj J 

" J to go one paragraph down
nmap J }
omap J }
xmap J }
" K to go one paragraph up
nmap K {
omap K {
xmap K {

" L to go to the end of the line
nmap L $
omap L $
xmap L $
" H to go to the beginning of the line
nmap H ^
omap H ^
xmap H ^

" ALE toggle
nmap ge :ALEEnable<CR>
nmap gE :ALEDisable<CR>

" Remove highlighting after searching
nmap <F3> :noh <CR>
imap <F3> jj:noh<CR>a

" Enables mouse scrolling up
nmap <SrollWheelUp> <C-Y> 
" Enables mouse scrolling down
nmap <SrollWheelDown> <C-E> 

" Snippets and abbreviations
" imap pf <Esc>:-1read /home/porco/printf<CR>>>f"a
" ab pf printf("");

" COLORS " -------------------------------------------------------------------------------------------

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
highlight Search ctermbg=255

" airline theme
let g:airline_theme="serene"

" ALE
highlight ALEError ctermbg=245
highlight ALEWarning ctermbg=245
highlight ALEInfo ctermbg=245
" Error, Info, and Warning are the three syntax note types
" ALEErrorLine is the error whole line
" ALEError is the error part only
" ALEErrorSign is the left sign

" CONFIG " ------------------------------------------------------------------------------------------

" set relativenumber
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
