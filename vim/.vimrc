"" load plugins
execute pathogen#infect()
set rtp+=/usr/local/opt/fzf

"" set theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

syntax on
set encoding=utf-8
set t_Co=256
set mouse=a

"" save automatically when calling make
set autowrite

"" no need to be compatible with vi and lose features.
set nocompatible

"" undo
set undofile
set undodir=~/.vim/undo

"" set leader
let mapleader=","

"" search settings
set hlsearch
set incsearch
set ignorecase
set smartcase
set gdefault
set wildmenu
set wildmode=full

"" buffer settings
set hidden
augroup vimrc
  au BufReadPre * setlocal foldmethod=syntax
  au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
augroup END
autocmd Syntax * normal zR

"" set textwidth to 80, this implies word wrap.
"" set textwidth=80
set synmaxcol=500

"" set column 80 to red
" highlight OverLength ctermbg=8 ctermfg=red
" match OverLength /\%121v.\+/

"" show line numbers.
set nu
set relativenumber

"" tabs settings
filetype plugin indent on
set autoindent
set breakindent
set showbreak=\\\\\

"" 4 space hard tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

"" 2 space tabs
" set softtabstop=2
" set tabstop=2
" set shiftwidth=2
" set expandtab

"" show matching braces
set showmatch

"" keep the horizontal cursor position when moving vertically
set nostartofline

"" do not break long lines
set nowrap
set listchars=eol:$,extends:>

"" always show the name of the file being edited
set ls=2

"" show the mode (insert,replace,etc.)
set showmode

"" no blinking cursor please
set gcr=a:blinkon0

"" do not show any line of minimized windows
set wmh=0
set wmw=0

"" after this many msecs do not imap
set timeoutlen=500

"" set update time to 0.5 second (default is 4 seconds), convenient for taglist.vim.
set updatetime=100

"" set backspace
set backspace=indent,eol,start

"" automatically close location lists when leaving a buffer
au BufWinLeave * if empty(&bt) | lclose | endif

"" move between splits
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

"" maps
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap ! :!
nnoremap <silent> <return> :w<CR>:wa<CR>
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <space> :tabn<CR>
nnoremap <backspace> :tabp<CR>
nnoremap gm m
nnoremap <silent> n /<CR>zz
nnoremap <silent> N ?<CR>zz
nnoremap <silent> <c-p> :lnext<CR>zz
nnoremap <silent> <c-o> :lprevious<CR>zz
" nnoremap <silent> <c-y> :cprevious<CR>zz
" nnoremap <silent> <c-u> :cnext<CR>zz
" nnoremap <silent> <c-q> :lcl<CR>

"" leader maps
nnoremap <Leader>s :source $HOME/.vimrc
nnoremap <Leader>v :e $HOME/.vimrc
nnoremap <Leader>sudo :w !sudo tee %
nnoremap <Leader>m :<c-u><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
nnoremap <Leader>j :set ft=javascript<CR>
nnoremap <Leader>h :set ft=html<CR>

"" abbreviations
iab lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

"" functions
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

"" plugins
let g:closetag_html_style=1
so ~/.vim/scripts/matchit.vim
so ~/.vim/scripts/closetag.vim

"" fzf
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
nnoremap <Leader>f :Find 
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>l :Lines<CR>

"" Neomake
au! BufWrite *.js,*.html,*.css,*.scss,*.py,*.json Neomake
let g:neomake_open_list=2
let g:neomake_list_height=10
let g:neomake_json_enabled_makers=['eslint']
let g:neomake_json_eslint_maker= {
	\ 'args': ['-f', 'compact', '-c', '/Users/biku1/.eslintrc'],
	\ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
	\ '%W%f: line %l\, col %c\, Warning - %m'
\ }
let g:neomake_javascript_enabled_makers=['eslint']
let g:neomake_javascript_eslint_maker= {
	\ 'args': ['-f', 'compact', '-c', '/Users/biku1/.eslintrc'],
	\ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
	\ '%W%f: line %l\, col %c\, Warning - %m'
\ }
let g:neomake_warning_sign = {
	\ 'text': 'W>'
\ }
let g:neomake_error_sign = {
	\ 'text': 'E>'
\ }

"" EasyClip settings
let g:EasyClipUseSubstituteDefaults=1
set clipboard=unnamed

"" UltiSnips settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"" Gutentags settings
let g:gutentags_cache_dir='~/.vim/tags'
let g:gutentags_ctags_exclude=[
	\'*.css', '*.html', '*.json', '*.xml',
	\ '*.phar', '*.ini', '*.rst', '*.md',
	\ 'node_modules', 'ios', 'android'
	\ ]
let g:tagbar_sort=0
let g:tagbar_compact=1
let g:tagbar_show_linenumbers=1

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
nnoremap <F1> :TagbarToggle<CR>
let g:tagbar_width=60

"" vim-go
let g:go_fmt_command = "goimports"
let g:go_snippet_case_type = "camelcase"
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
" let g:go_auto_type_info = 1

"" vim-json
let g:vim_json_syntax_conceal = 0
let g:vim_json_warnings=0

"" delete trailing whitespaces
au BufWritePre *.js,*.html,*.css,*.scss,*.py,*.json :%s/\s\+$//e

"" language specific mappings

"" javascript/json
au FileType javascript nnoremap <Leader>r :!babel-node --presets ~/.nvm/versions/node/v7.2.0/lib/node_modules/babel-preset-latest %<CR>
au FileType javascript,json nnoremap <Leader>t :!gulp test-server<CR>
au FileType javascript nnoremap <Leader>c "cdiWaconsole.log('<ESC>"cpa = ', <ESC>"cpa);<ESC>
au FileType javascript,json nnoremap <Leader>z $zfa}
au FileType javascript nnoremap <Leader>gc :g/console/exe "normal gcc"<CR>

"" golang
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

au FileType go map <Leader>r <Plug>(go-run)
au FileType go map <Leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go map <Leader>t <Plug>(go-coverage-toggle)
au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')

"" python
au FileType python nnoremap <Leader>r :!python %<CR>

"" c++
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

au FileType cpp nnoremap <silent> <F4> :call ToggleBetweenHeaderAndSourceFile()<CR>

"" tabs are needed in makefiles
au BufNewFile,BufReadPost Makefile set noexpandtab

"" autoresize splits when resizing window
autocmd VimResized * wincmd =
