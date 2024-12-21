" General {{{
" Python host
if $OS == "ubuntu"
  let g:python3_host_prog = '/home/ubuntu/.conda/bin/python3'
endif
if $OS == "macos"
  " let g:python3_host_prog = '~/.conda/bin/python3'
  " Use system clipboard
  set clipboard+=unnamedplus
endif
if $OS == "android"
  let g:python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'
  " Use system clipboard
  set clipboard+=unnamedplus
endif

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" Use par for prettier line formatting
set formatprg=par
let $PARINIT = 'rTbgqR B=.,?_A_a Q=_s>|'

" Kill the damned Ex mode.
nnoremap Q <nop>

" }}}

" Folding {{{

" Use indentation for folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

augroup vimrcFold
  " fold vimrc itself by categories
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd FileType vim set foldlevel=0
augroup END

" }}}

" Map Leader {{{

if ! exists("mapleader")
  let mapleader = ","
endif

if ! exists("g:mapleader")
  let g:mapleader = ","
endif

" Leader key timeout
set tm=2000

" Allow the normal use of "," by pressing it twice
noremap ,, ,

" }}}

" vim-plug {{{

if has('nvim')
  call plug#begin('~/.config/nvim/bundle')
else
  call plug#begin('~/.vim/bundle')
endif

Plug 'ervandew/supertab'

" Git
Plug 'tpope/vim-fugitive'
" Plug 'tap349/vim-extradite'
Plug 'airblade/vim-gitgutter'

" Bars, panels, and files
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'

" Text manipulation
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'michaeljsmith/vim-indent-object'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
" Plug 'SirVer/ultisnips'

" Highlighting
Plug 'jez/vim-ispc'

" Markdown
Plug 'tpope/vim-markdown'

if $OS != "android"
" Syntax & Auto Completion
  Plug 'fatih/vim-go', { 'for': ['go'] }
  Plug 'derekwyatt/vim-scala'
endif

" Colorscheme
Plug 'mhartington/oceanic-next'

call plug#end()

" }}}

" User Interface {{{

set wrap

" Set 7 lines to the cursor
set scrolloff=7

" Highlight cursor line
set cursorline

" Change cursor shape between insert and normal mode in iTerm.app
if $TERM_PROGRAM =~ "iTerm.app"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
  let &t_SR = "\<esc>]50;CursorShape=2\x7" " Underline in replace mode
endif

" Turn on the WiLd menu
set wildmenu
" Tab-complete files up to longest unambiguous prefix
set wildmode=list:longest,full

" Always show current position
set ruler
set number

" Set color column
set colorcolumn=110
" Show trailing whitespace
set list

" Height of the command bar
set cmdheight=1
set listchars=tab:▏\ ,trail:·

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


" No annoying sound on errors
set noerrorbells

" Force redraw
map <silent> <leader>R :redraw!<CR>

" Default to mouse mode on
set mouse=a
" }}}

" Search {{{

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" }}}

" Colors and Fonts {{{

if (has("nvim"))
  set termguicolors
endif

" Syntax highlighting
syntax enable

" Tell Vim what the background color looks like
set background=dark

" try setting the scheme
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" set the encoding if it's not neovim
if !has('nvim')
  set encoding=utf8
endif

" }}}

" Tab and indentation {{{

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

set ai "Auto indent
set si "Smart indent

" }}}

" Files {{{

" Turn backup off, since most stuff is in Git anyway...
set nobackup
set nowb
set noswapfile

" }}}

" Actions {{{

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" xnoremap p "_dP

nnoremap <silent> <leader>" :sp<CR>
nnoremap <silent> <leader>% :vsp<CR>
nnoremap <silent> <leader>w <C-W><C-W>

" Disable highlight when <leader><cr> is pressed
nmap <silent> <leader><cr> :noh<cr>

" Remap jj to escape
ino jj <esc>
cno jj <c-c>

" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" Remember info about open buffers on close
set viminfo^=%

" Utility function to delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWritePre * :call DeleteTrailingWS()

nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

nnoremap <leader>b :YcmCompleter GoTo<CR>

" Quit vim if it is the final buffer
function CountListedBuffers()
     let cnt = 0
     for nr in range(1,bufnr("$"))
         if buflisted(nr) && ! empty(bufname(nr))
             let cnt += 1
         endif
     endfor
     return cnt
endfunction

function QuitIfLastBuffer()
     if CountListedBuffers() == 0
         :quit
     endif
endfunction

" autocmd BufDelete * :call QuitIfLastBuffer()

" use wq to write and quit buffer
" :cnoreabbrev wq w<bar>bd
" use q to quite buffer
" :cnoreabbrev q bd
" use wq to write and quit buffer
nmap <silent> ZZ :w<bar>bd <bar> :call QuitIfLastBuffer()<CR>
" use wq to write and quit buffer
nmap <silent> ZQ :bd! <bar> :call QuitIfLastBuffer()<CR>

" }}}

" Easy Motion {{{

let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_shade = 1
let g:EasyMotion_skipfoldedline = 0
let g:EasyMotion_verbose = 0
let g:EasyMotion_prompt = '/ '

map fj <Plug>(easymotion-w)
map fk <Plug>(easymotion-b)

" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)

" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" }}}

" Airline {{{

" Always show the status line
set laststatus=2

" Use symbols for airline
let g:airline_powerline_fonts = 1
let g:airline_theme='oceanicnext'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9


let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" let g:airline_mode_map = {
"     \ '__' : '-',
"     \ 'n'  : '𝑵',
"     \ 'i'  : '𝙄',
"     \ 'R'  : '𝑹',
"     \ 'c'  : '𝑪',
"     \ 'v'  : '𝑽',
"     \ 'V'  : '𝑽',
"     \ '' : '𝑽',
"     \ 's'  : '𝑺',
"     \ 'S'  : '𝑺',
"     \ '' : '𝑺',
"     \ }

let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : '𝐍',
    \ 'i'  : '𝐈',
    \ 'R'  : '𝐑',
    \ 'c'  : '𝐂',
    \ 'v'  : '𝐕',
    \ 'V'  : '𝐕',
    \ '' : '𝐕',
    \ 's'  : '𝐒',
    \ 'S'  : '𝐒',
    \ '' : '𝐒',
    \ }

" let g:airline_section_z = '⍗%p%% ⯐ (%l,%c) %L'
let g:airline_section_z = '⯐ (%l,%c)'

let g:airline#extensions#tabline#buffer_idx_format = {
      \ '0': '⁰',
      \ '1': '¹',
      \ '2': '²',
      \ '3': '³',
      \ '4': '⁴',
      \ '5': '⁵',
      \ '6': '⁶',
      \ '7': '⁷',
      \ '8': '⁸',
      \ '9': '⁹'
      \}

" }}}

" Spell checking {{{

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "*",
    \ "Renamed"   : "r",
    \ "Unmerged"  : "m",
    \ "Deleted"   : "-",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✓",
    \ 'Ignored'   : "_",
    \ "Unknown"   : "?"
    \ }

" }}}

" Tagbar {{{

map <leader>tt :TagbarToggle<CR>

set tags=tags;/

" }}}

" Git {{{

" let g:extradite_width = 60
" " Hide messy Ggrep output and copen automatically
" function! NonintrusiveGitGrep(term)
"   execute "copen"
"   " Map 't' to open selected item in new tab
"   execute "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
"   execute "silent! Ggrep " . a:term
"   execute "redraw!"
" endfunction

" command! -nargs=1 GGrep call NonintrusiveGitGrep(<q-args>)
nmap <leader>gs :Gstatus<CR>
" nmap <leader>gg :copen<CR>:GGrep
" nmap <leader>gl :Extradite!<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>

function! CommittedFiles()
  " Clear quickfix list
  let qf_list = []
  " Find files committed in HEAD
  let git_output = system("git diff-tree --no-commit-id --name-only -r HEAD\n")
  for committed_file in split(git_output, "\n")
    let qf_item = {'filename': committed_file}
    call add(qf_list, qf_item)
  endfor
  " Fill quickfix list with them
  call setqflist(qf_list)
endfunction

" Show list of last-committed files
nnoremap <silent> <leader>g? :call CommittedFiles()<CR>:copen<CR>

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '⌅'
let g:gitgutter_sign_modified_removed = '≃'

let g:gitgutter_highlight_lines = 1

hi GitGutterAddLine           guifg=NONE  ctermfg=NONE  guibg=#1d3934  ctermbg=114
hi GitGutterDeleteLine        guifg=NONE  ctermfg=NONE  guibg=#2c1c25  ctermbg=203
hi GitGutterChangeLine        guifg=NONE  ctermfg=NONE  guibg=#12283b  ctermbg=024
hi GitGutterChangeDeleteLine  guifg=NONE  ctermfg=NONE  guibg=#282849  ctermbg=134

nnoremap <silent> <leader>gh :GitGutterLineHighlightsToggle<CR>

nmap ,hn <Plug>GitGutterNextHunk
nmap ,hN <Plug>GitGutterPrevHunk

" }}}

" Completion {{{

set completeopt+=longest

" Use buffer words as default tab completion
let g:SuperTabDefaultCompletionType = '<c-x><c-p>'
let g:ycm_autoclose_preview_window_after_insertion = 1

" }}}

" CtrlP {{{
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

nmap <leader>p :CtrlP<CR>
" }}}

" Vim Go{{{
" patch: cnext cprev loop back
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry

command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

cabbrev cnext Cnext
cabbrev cprev CPrev
cabbrev lnext Lnext
cabbrev lprev Lprev

au FileType go nmap <leader>r <Plug>(go-run-split)
" au FileType go nmap <leader>b <Plug>(go-def)
au FileType go nmap <leader>B <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>i <Plug>(go-info)
au FileType go nmap cn :cnext<CR>
au FileType go nmap cN :cprevious<CR>
au FileType go nmap ca :cclose<CR>

let g:go_fmt_command = "goimports"

set autowrite
" }}}

" Customization {{{
set noshowmode

let g:terminal_color_0 = "#142638"

let g:terminal_color_background = "#142638"

hi ErrorMsg guifg=#ec5f67 ctermfg=203 guibg=#17252C ctermbg=235

hi Conceal gui=bold guifg=#6699cc guibg=#17252C cterm=bold ctermfg=68 ctermbg=235
hi Cursor guifg=#17252C ctermfg=235 guibg=#c0c5ce ctermbg=251

hi CursorLine guifg=NONE ctermfg=NONE guibg=#1C2C33 ctermbg=251

hi Normal guifg=#c0c5ce ctermfg=251 guibg=#17252C ctermbg=235

hi SpellBad guibg=#17252C ctermbg=235 gui=undercurl cterm=undercurl
hi SpellLocal guibg=#17252C ctermbg=235 gui=undercurl cterm=undercurl
hi SpellCap guibg=#17252C ctermbg=235 gui=undercurl cterm=undercurl
hi SpellRare guibg=#17252C ctermbg=235 gui=undercurl cterm=undercurl

hi DiffFile guifg=#ec5f67 ctermfg=203 guibg=#17252C ctermbg=235
hi DiffNewFile guifg=#99c794 ctermfg=114 guibg=#17252C ctermbg=235
hi DiffLine guifg=#6699cc ctermfg=68 guibg=#17252C ctermbg=235

hi markdownError guifg=#c0c5ce ctermfg=251 guibg=#17252C ctermbg=235

hi vimfilerNormalFile guifg=#c0c5ce ctermfg=251 guibg=#17252C ctermbg=235

" Search and EasyMotion
hi IncSearch              guifg=NONE  guibg=NONE
hi Search                 guifg=#1A2B34  guibg=#FFFF00

" hi EasyMotionTarget        guifg=#D8DEEA  guibg=#EE5E64
" hi EasyMotionTarget2First  guifg=NONE  guibg=#2c1c25
" hi EasyMotionTarget2First  guifg=NONE  guibg=#12283b
" hi EasyMotionShade         guifg=NONE  guibg=#282849
hi EasyMotionIncSearch    guifg=#1A2B34  guibg=#FFFF00
" hi EasyMotionMoveHL        guifg=NONE  guibg=#282849
"
hi WhiteSpace guifg=#213540 guibg=None ctermfg=77 ctermbg=None

let g:UltiSnipsExpandTrigger = "jr"

" }}}
