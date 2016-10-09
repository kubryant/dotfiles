"" load plugins
execute pathogen#infect()
set rtp+=/usr/local/opt/fzf

"" Set theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

syntax on
set encoding=utf-8
set t_Co=256
set mouse=a

"" No need to be compatible with vi and lose features.
set nocompatible

"" Undo
set undofile
set undodir=~/.vim/undo

"" Set Leader
let mapleader=","

"" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Buffer settings
set hidden
set foldmethod=manual

"" Set textwidth to 80, this implies word wrap.
"" set textwidth=80
set synmaxcol=500

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
set wmh=0
set wmw=0

"" After this many msecs do not imap.
set timeoutlen=500

"" Set update time to 0.5 second (default is 4 seconds), convenient for taglist.vim.
set updatetime=250

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

"" Set backspace
set backspace=indent,eol,start

"" Cycling through Windows quicker.
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

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

"" Maps
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap ! :!
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <space> :tabn<CR>
nnoremap <backspace> :tabp<CR>
nnoremap gm m
nmap <silent> n /<CR>zz
nmap <silent> N ?<CR>zz

"" Leader maps
nnoremap <Leader>s :source $HOME/.vimrc
nnoremap <Leader>v :e $HOME/.vimrc
nnoremap <Leader>sudo :w !sudo tee %
nnoremap <Leader>m  :<c-u><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

"" Abbreviations
iab lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

"" Functions
function! HtmlEntities(line1, line2, action)
  let search = @/
  let range = 'silent ' . a:line1 . ',' . a:line2
  if a:action == 0
    execute range . 'sno/&amp;/&/eg'
    execute range . 'sno/&amp;/&/eg'
    execute range . 'sno/&lt;/</eg'
    execute range . 'sno/&gt;/>/eg'
    execute range . 'sno/&quot;/"/eg'
  else
    execute range . 'sno/</&lt;/eg'
    execute range . 'sno/"/&quot;/eg'
    execute range . 'sno/>/&gt;/eg'
    execute range . 'sno/&/&amp;/eg'
  endif
  nohl
  let @/ = search
endfunction
command! -range -nargs=1 Escape call HtmlEntities(<line1>, <line2>, <args>)

"" Plugins
let g:closetag_html_style=1 
so ~/.vim/scripts/matchit.vim
so ~/.vim/scripts/closetag.vim

"" fzf
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>l :Lines<CR>

"" Syntastic
nnoremap <silent> <Leader>t :SyntasticToggleMode<CR>
nnoremap <silent> <c-p> :lnext<CR>zz
nnoremap <silent> <c-o> :lprevious<CR>zz
let g:syntastic_mode_map={ 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_wq=0
let g:syntastic_loc_list_height=5

"" EasyClip settings
let g:EasyClipUseSubstituteDefaults=1
set clipboard=unnamed

"" UltiSnips settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"" Gutentags settings
let g:gutentags_cache_dir='~/.vim/tags'

"" Rainbow Parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs=[
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['white',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

"" TagBar settings
nmap <F1> :TagbarToggle<CR>
let g:tagbar_width=60

"" Javascript settings
nnoremap <Leader>c "cdiWaconsole.log('<ESC>"cpa = ', <ESC>"cpa);<ESC>
nnoremap <Leader>z $zfa}

"" Delete Trailing Whitespaces
au BufWritePre *.js,*.html,*.css,*.scss :%s/\s\+$//e

"" run commands
au FileType javascript :map <Leader>r :!node %<CR>
au FileType go :map <Leader>r :!go run %<CR>
au FileType python :map <Leader>r :!python %<CR>
