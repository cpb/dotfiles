" load pathogen
runtime bundle/core/pathogen/autoload/pathogen.vim
call pathogen#infect('~/.dotfiles/vim/bundle/tools/{}')
call pathogen#infect('~/.dotfiles/vim/bundle/langs/{}')
call pathogen#infect('~/.dotfiles/vim/bundle/colors/{}')

filetype plugin indent on

" Fixes typing p in ctrlp buffer https://github.com/ctrlpvim/ctrlp.vim/issues/447#issuecomment-396881940
let g:pasta_disabled_filetypes = ['ctrlp']

set nocompatible
set number
set ruler
syntax on
set encoding=utf-8
set laststatus=2 " always show the status bar
set backspace=start,eol,indent

" leader character
let mapleader = ","

" whitespace
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set list listchars=tab:▸\ ,trail:·

" backups
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup

" files to ignore
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,*.rbc,*.class,vendor/gems/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png
set wildignore+=*.zip,*.apk

" allow mouse clicks
set mouse=a

" show matching brackets.
set showmatch

" bounce between brackets
nmap <tab> %
vmap <tab> %
runtime! macros/matchit.vim

" show in title bar
set title

" search
set hlsearch
set ignorecase
set smartcase
set incsearch
nnoremap <leader><space> :noh<cr>

" wrap at word
set linebreak

" colorscheme
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
" set termguicolors
set background=dark
" let g:solarized_contrast="normal"
" let g:solarized_visibility="high"
" depends on iterm color profiles beecause it is made by color nerds
" doesn't appear to have key-value contrast in method arguments
" doesn't appear to have the negative space contrast 'feature' of all the ones
" below
" colorscheme solarized

" beautiful light cyan instance variables
" nice emphasise on comments
" lacks key value contrast
" colorscheme desertEx

" decepticons, slightly weird contrast on class names
" colorscheme liquidcarbon

" under emphasizes comments
" nice key-value contrast
"minty
"colorscheme Tomorrow
colorscheme Tomorrow-Night-Eighties
"camo
"colorscheme Tomorrow-Night

" make cursor move by visual lines instead of file lines (when wrapping)
map k gk
map j gj
map E ge

" force hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" start/end of line
map H ^
map L $

" shorcuts
nnoremap ; :
inoremap jj <ESC>

" save when focus lost
au FocusLost * :wa

" new split
nnoremap <leader>s<space> <C-w>v<C-w>l
nnoremap <leader>vs <C-w><C-v>
nnoremap <leader>hs <C-w><C-s>

" navigate splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" navigate buffers
map <A-h> :bp<CR>
map <A-l> :bn<CR>

" move lines up and down
map <A-j> :m +1 <CR>
map <A-k> :m -2 <CR>

" clean whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" sudo write
cmap w!! w !sudo tee % >/dev/null

" NERDTree
map <F2> :NERDTreeToggle<cr>
map <leader>n :NERDTreeToggle<cr>
map <leader>N :NERDTreeFind<cr>
let NERDTreeIgnore=['.vim$', '\~$']

" copy to clipboard
vmap <leader>y "+y
" copy current line to clipboard
nmap <leader>Y "+yy
" paste from clipboard
nmap <leader>p "+gP

" show the registers from things cut/yanked
nmap <leader>r :registers<CR>

" fix issues with screen and ctrl+left/right
set term=xterm-256color

" highlight current line
set cursorline

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript
" enabled spell checking in git commit
autocmd FileType gitcommit setlocal spell

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_auto_loc_list=2

" tagbar
map <leader>rt :TagbarToggle<cr>

" ctrlp
let g:ctrlp_map = '<c-t>'
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
\ }
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" ack
if executable('ack-grep')
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif
if executable("ag")
  " https://github.com/ggreer/the_silver_searcher
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" yankring
let g:yankring_history_dir = '~/.vim/tmp'
let g:yankring_history_file = 'yankring_history'

" airline (status line)
let g:airline_left_sep=''
let g:airline_right_sep=''

set exrc
set secure

let g:mkdp_auto_close = 0

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

let g:ale_linters = {
\  'ruby': ['standardrb', 'reek', 'ruby'],
\}

let g:ale_fixers = {
\  'ruby': ['standardrb'],
\}

" let g:ale_ruby_rubocop_executable = '.bundle/bin/rubocop'
" let g:ale_ruby_rubocop_auto_correct_all = 1

let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'

" show errors/warnings in airline
let g:airline#extensions#ale#enabled = 1
