"*******************************************************************************
"
"********* OPTIONS *************************************************************

filetype off
filetype plugin indent on
syntax on
set encoding=utf-8
set termencoding=utf-8
set autoindent
set t_Co=256
set path+=**
set expandtab
set tabstop=2
set shiftwidth=2
set mouse=a
set noshowmode
set lazyredraw
set showmatch
set foldmethod=marker
set foldlevelstart=10
set foldnestmax=10
set number
set hidden
set splitbelow
set splitright
set ruler
set list
set winwidth=79
set listchars=tab:>.,trail:~,extends:>,precedes:<,nbsp:␣
set modifiable
set laststatus=2
set updatetime=300
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,.git/*,node_modules/*
set signcolumn=auto
set incsearch
set shortmess+=aT
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//
set undofile
set backup
set cursorline
set diffopt+=hiddenoff

if has("nvim")
  set clipboard=unnamedplus
  set inccommand=split
else
  set clipboard=unnamed
endif

if !isdirectory($HOME . "/.vim/backup")
  call mkdir($HOME . "/.vim/backup", "p")
endif

if !isdirectory($HOME . "/.vim/swap")
  call mkdir($HOME . "/.vim/swap", "p")
endif

if !isdirectory($HOME . "/.vim/undo")
  call mkdir($HOME . "/.vim/undo", "p")
endif

"*******************************************************************************
"
"********* GUI OPTIONS *********************************************************

set guioptions-=T
set guioptions-=m
set guioptions-=c
set guifont=Hack:h16

"*******************************************************************************
"
"********* MAPPINGS ************************************************************

let mapleader = ","
let maplocalleader="\<space>"

nnoremap j gj
nnoremap k gk
inoremap jj <esc>
noremap <leader><space> :call DeleteTrailingWS()<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
nnoremap t0  :tabfirst<CR>
nnoremap tl  :tabnext<CR>
nnoremap th  :tabprev<CR>
nnoremap t$  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
nnoremap tn :tabnew<CR>
nnoremap <leader>ev :vsplit $MYVIMRC <cr>
nnoremap <leader>sv :source $MYVIMRC <cr>

"*******************************************************************************
"
"********* FUNCTIONS ***********************************************************

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

func! BufferCount()
 return len(getbufinfo({'buflisted':1}))
endfunc

"*******************************************************************************
"
"********* PLUGINS *************************************************************

if has("unix")
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

if has('win32') || has('win64')
  if has('nvim')
    if empty(glob('$HOME\AppData\Local\nvim\autoload\plug.vim'))
      silent ! powershell (md "$env:USERPROFILE\AppData\Local\nvim\autoload")
      silent ! powershell (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', $env:USERPROFILE + '\AppData\Local\nvim\autoload\plug.vim')
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
  else
    if empty(glob('$HOME\vimfiles\autoload\plug.vim'))
      silent ! powershell (md "$env:USERPROFILE\vimfiles\autoload")
      silent ! powershell (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', $env:USERPROFILE + '\vimfiles\autoload\plug.vim')
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
  endif
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'thaerkh/vim-workspace'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dhruvasagar/vim-table-mode'
Plug 'vimwiki/vimwiki'
Plug 'arcticicestudio/nord-vim'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'APZelos/blamer.nvim'
call plug#end()

"*******************************************************************************
"
"********* TERMINAL ************************************************************

if has('nvim')
  au TermOpen * setlocal nonumber list
endif

"*******************************************************************************
"
"********* FLOATERM ************************************************************
" URL: https://github.com/voldikss/vim-floaterm
" Plugin: voldikss/vim-floaterm

function s:floatermSettings()
    tnoremap <silent> <buffer> <C-[> <C-\><C-n>:FloatermKill!<CR>
endfunction

let g:floaterm_autoclose = 2
let g:floaterm_autohide = 0
let g:floaterm_title = ""
let g:floaterm_width = 0.7

autocmd FileType floaterm call s:floatermSettings()

"*******************************************************************************
"
"********* VIFM ****************************************************************

nnoremap <silent> <C-e> :FloatermNew vifm <CR>

"*******************************************************************************
"
"********* GIT GUTTER **********************************************************
" URL: https://github.com/airblade/vim-gitgutter
" Plugin: airblade/vim-gitgutter

let g:gitgutter_use_location_list = 0
let g:gitgutter_preview_win_floating = 0

"*******************************************************************************
"
"********* GIT BLAMER **********************************************************
" URL: https://github.com/APZelos/blamer.nvim
" Plugin: APZelos/blamer.nvim

if has("unix")
  let g:blamer_enabled = 1
endif

"*******************************************************************************
"
"********* THEMING *************************************************************
" URL: https://github.com/arcticicestudio/nord-vim
" Plugin: arcticicestudio/nord-vim

if (has("nvim"))
 let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if ($TERM_PROGRAM != 'Apple_Terminal')
 set termguicolors
endif

colorscheme nord

let g:nord_italic = 1
let g:nord_bold = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_status_lines = 1

call matchadd('ColorColumn', '\%81v', 100) "show when line goes over 80 lines

"*******************************************************************************
"
"********* POLYGOT *************************************************************
" URL: https://github.com/sheerun/vim-polyglot
" Plugin: sheerun/vim-polyglot

"let g:polyglot_disabled = ['latex']

"*******************************************************************************
"
"********* LIGHTLINE ***********************************************************
" URL: https://github.com/itchyny/lightline.vim
" Plugin: itchyny/lightline.vim

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus']],
      \   'right': [ [ 'lineinfo', 'buffercount' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'StatusDiagnostic',
      \   'buffercount': 'BufferCount'
      \ },
      \ }

"*******************************************************************************
"
"********* FZF *****************************************************************
" URL: https://github.com/junegunn/fzf.vim
" Plugin: junegunn/fzf.vim

set rtp+=/usr/local/opt/fzf

let $FZF_DEFAULT_COMMAND = 'ag --hidden --skip-vcs-ignores -l -g ""'

nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>g :GFiles?<CR>

if has("unix")
  let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.6, 'yoffset': 0.1, 'xoffset': 0.5, 'border': "sharp" } }
  let g:fzf_preview_window = ['down:60%']
else
  let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.3, 'yoffset': 0.1, 'xoffset': 0.6, 'border': "top" } }
  let g:fzf_preview_window = []
endif

let g:fzf_buffers_jump = 1

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"*******************************************************************************
"
"********* COC *****************************************************************
" URL: https://github.com/neoclide/coc.nvim
" Plugin: neoclide/coc.nvim

let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-html',
    \ 'coc-emmet',
    \ 'coc-eslint',
    \ 'coc-prettier',
    \ 'coc-css'
\ ]

autocmd CursorHold * silent call CocActionAsync('highlight')

command! -nargs=0 Prettier :CocCommand prettier.formatFile

nmap <leader>qf  <Plug>(coc-fix-current)
nmap <silent> gd <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"*******************************************************************************
"
"********* MULTICURSOR *********************************************************
" URL: https://github.com/mg979/vim-visual-multi
" Plugin: terryma/vim-multiple-cursors

let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-n>'
let g:VM_maps['Find Subword Under'] = '<C-n>'

"*******************************************************************************
"
"********* WORKSPACE ***********************************************************
" URL: https://github.com/thaerkh/vim-workspace
" Plugin: thaerkh/vim-workspace

let g:workspace_autosave = 0
let g:workspace_session_directory = $HOME . '/.vim/sessions/'
let g:workspace_undodir = $HOME . '/.vim/undo'
let g:workspace_create_new_tabs = 0

"*******************************************************************************
"
"********* VIMWIKI *************************************************************
" URL: https://github.com/vimwiki/vimwiki
" Plugin: vimwiki/vimwiki

let g:vimwiki_list = [{'path':'~/SynologyDrive/Wiki/text/', 'path_html':'~/SynologyDrive/Wiki/html/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_table_mappings=0
let g:vimwiki_table_auto_fmt=0

nmap tt <Plug>VimwikiToggleListItem

"*******************************************************************************
"
"********* TABLE MODE **********************************************************
" URL: https://github.com/dhruvasagar/vim-table-mode
" Plugin: dhruvasagar/vim-table-mode

let g:table_mode_corner='|'

"*******************************************************************************
"
"********* EMMET ***************************************************************
" URL: https://github.com/mattn/emmet-vim
" Plugin: mattn/emmet-vim

let g:user_emmet_leader_key="<C-Z>"

"*******************************************************************************
"
"********* GO ******************************************************************
" URL: https://github.com/fatih/vim-go
" Plugin: fatih/vim-go

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_methods = 1
let g:go_version_warning = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

"*******************************************************************************
"
"********* LATEX ***************************************************************
" URL: https://github.com/lervag/vimtex
" Plugin: lervag/vimtex

let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'nvr'
autocmd Filetype tex setl updatetime=1

"*******************************************************************************
"
"********* MAIL ****************************************************************

autocmd FileType mail set noautoindent |
      \ setlocal nosmartindent |
      \ setlocal textwidth=72 |
      \ setlocal nonumber |
      \ setlocal spell spelllang=nl,en_us
