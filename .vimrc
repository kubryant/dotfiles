"" Set theme
colorscheme slate
syntax on

"" No need to be compatible with vi and lose features.
set nocompatible

set hlsearch

"" Set textwidth to 80, this implies word wrap.
""set textwidth=80

"" Set column 80 to red
""highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
""match OverLength /\%81v.\+/

"" Show line numbers.
set nu

"" Fix giant tabs
set softtabstop=4

"" Automatic C-style indenting.
set autoindent

"" When inserting TABs replace them with the appropriate number of spaces
set expandtab

"" But TABs are needed in Makefiles
au BufNewFile,BufReadPost Makefile se noexpandtab

"" Show matching braces.
set showmatch

"" Choose the right syntax highlightning per TAB-completion :-)
"" map <F2> :source $VIM/syntax/

"" Set update time to 1 second (default is 4 seconds), convenient vor taglist.vim.
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

"" Keep the horizontal cursor position when moving vertically.
set nostartofline

"" Reformat comment on current line. TODO: explain how.
map <silent> hc ==I  <ESC>:.s/\/\/ */\/\//<CR>:nohlsearch<CR>j

"" Make sure == also indents #ifdef etc.
noremap <silent> == IX<ESC>==:.s/X//<CR>:nohlsearch<CR>

"" Toggle encoding with F12.
function! ToggleEncoding()
  if &encoding == "latin1"
    set encoding=utf-8
  elseif &encoding == "utf-8"
    set encoding=latin1
  endif
endfunction
map <silent> <F12> :call ToggleEncoding()<CR>

"" Do not break long lines.
set nowrap
set listchars=eol:$,extends:>

"" Next / previous error with Tab / Shift+Tab.
map <silent> <Tab> :cn<CR>
map <silent> <S+Tab> :cp<CR>
map <silent> <BS><Tab> :cp<CR>

"" After this many msecs do not imap.
set timeoutlen=500

"" Always show the name of the file being edited.
"" set ls=2

"" Show the mode (insert,replace,etc.)
set showmode
 
"" No blinking cursor please.
set gcr=a:blinkon0

"" Cycle through completions with TAB (and SHIFT-TAB cycles backwards).
function! InsertTabWrapper(direction) 
    let col = col('.') - 1 
    if !col || getline('.')[col - 1] !~ '\k' 
        return "\<tab>" 
    elseif "backward" == a:direction 
        return "\<c-p>" 
    else 
        return "\<c-n>" 
    endif 
endfunction 
inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

"" Cycling through Windows quicker.
map <C-M> <C-W>j<C-W>_ 
map <C-K> <C-W>k<C-W>_ 
map <A-Down>  <C-W><Down><C-W>_
map <A-Up>    <C-W><Up><C-W>_
map <A-Left>  <C-W><Left><C-W>|
map <A-Right> <C-W><Right><C-W>|

"" Do not show any line of minimized windows
set wmh=0

"" Make it easy to update/reload _vimrc.
:nmap ,s :source $HOME/.vimrc 
:nmap ,v :sp $HOME/.vimrc 

"" Latex Suite 1.5 wants it
"" REQUIRED. This makes vim invoke latex-suite when you open a tex file.
filetype plugin on

"" IMPORTANT: grep will sometimes skip displaying the file name if you
"" search in a singe file. This will confuse latex-suite. Set your grep
"" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*

"" OPTIONAL: This enables automatic indentation as you type (by 4 spaces)
filetype indent on
set sw=4

"" no placeholders please
let g:Imap_UsePlaceHolders = 0

"" no " conversion please
let g:Tex_SmartKeyQuote = 0

"" don't use Makefile if one is there
let g:Tex_UseMakefile = 0
