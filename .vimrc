"" Set theme
colorscheme bryantpeach
syntax on
set encoding=utf-8

"" No need to be compatible with vi and lose features.
set nocompatible

"" Set Leader
let mapleader=","

"" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Buffer settings
set hidden

"" Set textwidth to 80, this implies word wrap.
"" set textwidth=80
set synmaxcol=250

"" Set column 80 to red
"" highlight OverLength ctermbg=8 ctermfg=red
"" match OverLength /\%81v.\+/

"" Show line numbers.
set nu
set relativenumber

"" Tabs settings
filetype plugin indent on
set autoindent
"" 4 space hard tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

"" 2 space tabs
"" set softtabstop=2
"" set tabstop=2
"" set shiftwidth=2
"" set expandtab

"" But TABs are needed in Makefiles
au BufNewFile,BufReadPost Makefile se noexpandtab

"" Show matching braces.
set showmatch

"" Choose the right syntax highlightning per TAB-completion :-)
"" map <F2> :source $VIM/syntax/

"" Keep the horizontal cursor position when moving vertically.
set nostartofline

"" Do not break long lines.
set nowrap
set listchars=eol:$,extends:>

"" Always show the name of the file being edited.
set ls=2

"" Show the mode (insert,replace,etc.)
set showmode

"" No blinking cursor please.
set gcr=a:blinkon0

"" Do not show any line of minimized windows
"" set wmh=0

"" After this many msecs do not imap.
set timeoutlen=500

"" Set update time to 1 second (default is 4 seconds), convenient for taglist.vim.
set updatetime=500

"" Toggle between .h and .cpp with F4.
function! ToggleBetweenHeaderAndSourceFile()
  let bufname = bufname("%")
  let ext = fnamemodify(bufname, ":e")
  if ext == "h"
    let ext = "cpp"
  elseif ext == "cpp"
    let ext = "h"
  else
    return
  endif
  let bufname_new = fnamemodify(bufname, ":r") . "." . ext
  let bufname_alt = bufname("#")
  if bufname_new == bufname_alt
    execute ":e#"
  else
    execute ":e " . bufname_new
  endif
endfunction
map <silent> <F4> :call ToggleBetweenHeaderAndSourceFile()<CR>

"" Cycle through completions with TAB (and SHIFT-TAB cycles backwards).
"" function! InsertTabWrapper(direction)
""     let col = col('.') - 1
""     if !col || getline('.')[col - 1] !~ '\k'
""         return "\<tab>"
""     elseif "backward" == a:direction
""         return "\<c-p>"
""     else
""         return "\<c-n>"
""     endif
"" endfunction
"" inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
"" inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

"" Latex Suite 1.5 wants it
"" REQUIRED. This makes vim invoke latex-suite when you open a tex file.

"" IMPORTANT: grep will sometimes skip displaying the file name if you
"" search in a single file. This will confuse latex-suite. Set your grep
"" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*

"" no placeholders please
let g:Imap_UsePlaceHolders = 0

"" no " conversion please
let g:Tex_SmartKeyQuote = 0

"" don't use Makefile if one is there
let g:Tex_UseMakefile = 0

"" wildignore
set wildignore+=*.a,*.o,*.class
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_STORE,.git,.hg,.svn
set wildignore+=*/node_modules/*
set wildignore+=*/target/*

"" Set backspace
set backspace=indent,eol,start

"" Cycling through Windows quicker.
"" map <C-M> <C-W>j<C-W>_
"" map <C-K> <C-W>k<C-W>_
"" map <A-Down>  <C-W><Down><C-W>_
"" map <A-Up>    <C-W><Up><C-W>_
"" map <A-Left>  <C-W><Left><C-W>|
"" map <A-Right> <C-W><Right><C-W>|

"" HARD MODE
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>

"" Buffer maps
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>

"" Leader maps
nnoremap <Leader>s :source $HOME/.vimrc
nnoremap <Leader>v :e $HOME/.vimrc
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>sudo :w !sudo tee %

"" Plugins
so /usr/local/Cellar/vim/7.4.884/share/vim/vim74/macros/matchit.vim
so ~/.vim/closetag.vim
execute pathogen#infect()

"" CtrlP Settings
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'

"" Syntastic settings
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        Errors
    endif
endfunction

nnoremap <silent> <Leader>e :<C-u>call ToggleErrors()<CR>
nnoremap <silent> <Leader>t :SyntasticToggleMode<CR>
nnoremap <silent> <C-p> :lnext<CR>zz
nnoremap <silent> <C-o> :lprevious<CR>zz
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=5