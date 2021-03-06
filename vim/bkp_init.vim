set shell=/bin/zsh

set hidden

" Leader key
let mapleader = "\<SPACE>"
let g:mapleader = "\<SPACE>"

" Remove scrolls bars from macvim
set guioptions=

" Shortcut to open vim rc
nmap <leader>vr :sp ~/dotfiles/vim/init.vim<cr>

" Shortcut to open vim plugins
nmap <leader>vp :sp ~/dotfiles/vim/plugins.vim<cr>

" Shortcut to reload vim config
nmap <leader>so :source $MYVIMRC<cr>

" Copy to clipboard from vim
set clipboard+=unnamed

set termguicolors
syntax enable

hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

set visualbell    " don't beep
set noerrorbells  " don't beep
set autoread " Auto read when a file is changed on disk"
set autoindent
set copyindent
set number " line numbers
set relativenumber number
set showmode " always show mode
set showcmd " Show (partial) command in status line.
set noshowmode  " dont show default status line
set cursorline " highlight current line
set history=100
set undolevels=10000  " Use more levels of undo"
" dont use backup files
set nobackup
set nowritebackup
set noswapfile
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp   " store swap files here
" Search things
set incsearch   " show search matches as you type
set ignorecase  " case insensitive search
set smartcase   " If a capital letter is included in search, make it case-sensitive
set nohlsearch  " dont highlight search results
set ttimeoutlen=0 " Remove 'esc' delay
set tabstop=2
set shiftwidth=2

" Start find/replace
noremap <leader>r :%s/

" Paste mode
nnoremap <leader>o :set invpaste<CR>

" Tired of :w :q and :W
nnoremap ;w :w<CR>
nnoremap ;q :q<CR>
nnoremap ;wq :wq<CR>
nnoremap ;qa :qa<CR>
nnoremap :W :w<CR>
nnoremap :Wq :wq<CR>

" Selecting last pasted or changed text
nnoremap <expr> <leader>gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Open splits on right and below
set splitbelow
set splitright

" Open Clap (browser explorer)
noremap <leader>p :Clap files<CR>
noremap <leader>b :Clap buffers<CR>

" bind K to grep word under cursor
nnoremap F :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

nnoremap \ :Ag<SPACE>

" allow saving a sudo file if forgot to open as sudo
cmap w!! w !sudo tee % >/dev/null

" Disable arrow keys"
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
   let t:curwin = winnr()
   exec "wincmd ".a:key
   if (t:curwin == winnr())
       if (match(a:key,'[jk]'))
           wincmd v
       else
           wincmd s
       endif
       exec "wincmd ".a:key
   endif
endfunction

" Split navigation with something fancy :)
map <silent> <leader>h :call WinMove('h')<CR>
map <silent> <leader>j :call WinMove('j')<CR>
map <silent> <leader>k :call WinMove('k')<CR>
map <silent> <leader>l :call WinMove('l')<CR>

" Toggle NerdTree
noremap <Leader>f :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeFind<CR>

" Open NerdTree on current file
nnoremap <silent> <Leader>c :NERDTreeFind<CR>
" Making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeIgnore=['\~$', 'deps', '_build']
let NERDTreeShowHidden=1

" Add javascript syntax to es6, es7 files
autocmd BufNewFile,BufRead *.es6   set syntax=javascript
autocmd BufNewFile,BufRead *.es7   set syntax=javascript

" Add javascript syntax to typescript
autocmd BufNewFile,BufRead *.ts set syntax=javascript

" Add html to eex
autocmd BufNewFile,BufRead *.eex set syntax=html

" Add json syntax to babelrc
autocmd BufNewFile,BufRead *.babelrc set syntax=json

" Add Slim syntax
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
autocmd BufNewFile,BufRead *.lime setlocal filetype=slim

" Add spell checking and wrap at 72 columns git commit message
autocmd Filetype gitcommit setlocal spell textwidth=72

" Load plugins
source ~/dotfiles/vim/plugins.vim

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Set terminal to vim-test
let g:test#strategy = 'vimux'

" Setup Elixir Umbrella test
function! ElixirUmbrellaTransform(cmd) abort
  if match(a:cmd, 'apps/') != -1
    return substitute(a:cmd, 'mix test apps/\([^/]*/\)', 'cd apps/\1 \&\& mix test ', '')
  else
    return a:cmd
  end
endfunction

" Remap ESC to not close the test window.
tnoremap <Esc> <C-\><C-n>

let g:test#preserve_screen = 1
let g:test#custom_transformations = {'elixir_umbrella': function('ElixirUmbrellaTransform')}
let g:test#transformation = 'elixir_umbrella'

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Vim-test key bindings
nmap <silent> <leader>tt :TestFile<CR>
nmap <silent> <leader>ts :TestNearest<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" Linters setup
set nocompatible
filetype off
filetype plugin on

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Copy the current path to clipboard
nnoremap <Leader>yc :let @+=expand('%:p')<CR>

" Copy the current path with line number to clipboard
nnoremap <leader>yp :let @+=expand('%:p') . ':' . line(".")<CR>

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:elixir_autoformat_enabled = 0
let g:mix_format_on_save = 0

au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Set mouse on
set mouse=a

" Vim & Tmux

function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction

" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <Leader>vs "vy :call VimuxSlime()<CR>

" Select current paragraph and send it to tmux
nmap <Leader>vs vip<LocalLeader>vs<CR>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

" Open tmux pane or use the nearest one.
map <Leader>vo :call VimuxOpenRunner()<CR>

" Format JSON usin jq library: https://github.com/stedolan/jq
map <Leader>jq :%!jq<CR>
