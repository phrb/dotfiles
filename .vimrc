" Don't use backups
" Replace backups with Git and persistent undo files
set nobackup
set nowritebackup

" No folds allowed
set nofoldenable
set foldmethod=indent

" Plugins with VimPlug
" https://github.com/junegunn/vim-plug
call plug#begin()

" Indent Guides
" Plug 'nathanaelkane/vim-indent-guides'

" Fugitive
" Plug 'tpope/vim-fugitive'

" Surround
" Plug 'tpope/vim-surround'

" Python
Plug 'hdima/python-syntax'

" C
Plug 'justinmk/vim-syntax-extra'

" Julia
Plug 'JuliaEditorSupport/julia-vim'

" base16 colors
" fix for https://github.com/chriskempson/base16-vim/issues/197
function FixupBase16(info)
    !sed -i '/Base16hi/\! s/a:\(attr\|guisp\)/l:\1/g' ~/.vim/plugged/base16-vim/colors/*.vim
endfunction
Plug 'chriskempson/base16-vim', { 'do': function('FixupBase16') }

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Get rid of weird airline bug
set t_RV=

" EasyAlign
Plug 'junegunn/vim-easy-align'

"End Plugins
call plug#end()


" Highlight past searches
set hlsearch

" Set encoding
set encoding=utf-8
set fileencoding=utf-8

" History size
set history=8192

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Sets line numbers
set number

"Set terminal title to filename
set title

" Persistent undos
set undofile

" Undo history
set undodir=/home/phrb/.vimundo/

" Cursor surrounding lines
set so=3

" Show matching brackets on cursor hover
set showmatch

" Remove intro message
set shortmess=IatT

" No sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Solves :WQ problem
ca WQ wq
ca Wq wq
ca wQ wq
ca Q  q
ca W  w

" Set command-line window height
set cmdwinheight=3

" Set fast connection to tty
set ttyfast

" Usually annoys me
" set nowrap

" Only ignore case for all lower case
set ignorecase
set smartcase

"\l to toggle visible whitespace
nmap <silent> <leader>l :set list!<CR>

"\s to toggle spell checking
nmap <silent> <leader>s :set spell! spelllang=pt_br<CR>

"\s to toggle spell checking
nmap <silent> <leader>e :set spell! spelllang=en<CR>

"F2 toggle pastemode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Highlight everything in Python
let python_highlight_all = 1

set autoindent

syntax on

" Use spaces instead of tabs
set expandtab

" Tab options
set shiftwidth=4
set tabstop=4
set softtabstop=4

" No delays on mode change
set ttimeoutlen=0

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Configure Base16
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set background=dark
colorscheme base16-default-dark

" Configure airline
let g:airline_theme='base16'

let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

let g:airline_powerline_fonts=1

set noshowmode

" Stop cursor blinking
set guicursor=

" Highlight current line (disabled until fixed)
" set cursorline
" set synmaxcol=256

" Cleaner and lighter syntax highlights for .tex and .bib
"autocmd FileType tex :NoMatchParen
au FileType tex setlocal nocursorline
au FileType tex :set synmaxcol=128
"autocmd FileType bib :NoMatchParen
"au FileType bib setlocal nocursorline

" Highlight characters at the 80th collumn
highlight ColorColumn ctermbg=246 ctermfg=white guibg=#592929
call matchadd('ColorColumn', '\%81v', 100)

" Reselect after indent so it can easily be repeated
 vnoremap < <gv
 vnoremap > >gv

" Configure indent guide
" Automatically use indent guides
let g:indent_guides_enable_on_vim_startup=1
" Choose own guide colors
let g:indent_guides_auto_colors=0
" Guide width is 1 character column
let g:indent_guides_guide_size=1
" Explicit odd-numbered line color
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
" Explicit even-numbered line color
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

" Jump to last position on reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
