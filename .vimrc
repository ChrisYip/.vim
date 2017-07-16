" Global variables for environment
let isMac = has('mac')
let isWin = has('win32') || has ('win64')
let isGui = has('gui_running')

set guifont=Source_Code_Pro:h15

if isWin
    " make correct encoding for menu
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    " set behaviour for win
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim

    " maximize window when opening
    au GUIEnter * simalt ~x

    " in case of 'diffexpr' is empty
    set diffexpr=MyDiff()
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" enable some feature on mswin like shift + arrow to select text
behave mswin

" set encoding
set encoding=utf-8
set termencoding=utf-8
set fencs=ucs-bom,utf-8,gb18030,gbk,gb2312,big5,euc-jp,euc-kr,latin1,cp936
set fileencoding=utf-8
set ff=unix

" set line number
set nu

" enable search highlights
set hls

" When vimrc is edited, reload it
au! bufwritepost vimrc source % 

" Correct console's encoding
language messages en_US.utf-8

" Vundle setup
set nocompatible
filetype off

" Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'L9'

Plugin 'tpope/vim-surround'

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Respect .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = '\v\.(png|jpe?g|gif|mp3|mp4|app|dmg|zip|swp|so)$'
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
  \ }

Plugin 'editorconfig/editorconfig-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'chrisbra/SudoEdit.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'Yggdroot/indentLine'

if has('lua')
  Bundle 'Shougo/neocomplete.vim'
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_auto_select = 1
end

Plugin 'scrooloose/nerdcommenter'

Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='vertical'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'kablamo/vim-git-log'
Plugin 'airblade/vim-gitgutter'

" Theme
Plugin 'altercation/vim-colors-solarized'
Plugin 'joshdick/onedark.vim'
set background=dark
Plugin 'w0ng/vim-hybrid'

" Front-end
Plugin 'kchmck/vim-coffee-script'
" Plugin 'digitaltoad/vim-jade'
Plugin 'digitaltoad/vim-pug'
Plugin 'genoma/vim-less'
Plugin 'wavded/vim-stylus'
Plugin 'mattn/emmet-vim'
Plugin 'posva/vim-vue'
Plugin 'mxw/vim-jsx'
" JSDoc highlight
Plugin 'othree/jsdoc-syntax.vim'

Plugin 'pangloss/vim-javascript'
let javascript_enable_domhtmlcss=1
Plugin 'isRuslan/vim-es6'

Plugin 'elzr/vim-json'

" Open file base on node's require('module_name')
Plugin 'moll/vim-node'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

Plugin 'scrooloose/syntastic'
let g:syntastic_javascript_checkers = ['eslint']

Plugin 'gosukiwi/vim-atom-dark'

Plugin 'rust-lang/rust.vim'

call vundle#end()

filetype plugin indent on

" set theme & highlight
syntax on

if isGui
  colorscheme onedark
else
  colorscheme onedark
endif

au BufEnter * if &filetype == "" | setlocal ft=markdown | endif
au BufWinEnter *.txt set ft=markdown
au BufNewFile,BufRead * setfiletype markdown

" set case sensitive
set ignorecase smartcase

" No sound on errors
set noerrorbells
set novisualbell
set vb t_vb=

" set auto backup for work's files
set nobackup
set backupext=.bak

" show last line but '@'
set dy=lastline

" Text, tab and indent related
set expandtab smarttab
set shiftwidth=2
set tabstop=2

" breaking lines
set lbr
set tw=500

" set indent
set ai " auto indent
set si " smart indent

" set cursor line highlight
au InsertEnter * set cul
au InsertLeave * set nocul

"key mapping
nmap <F2> :nohls <CR>

" Command maps
" Map :E to :Explore
command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

nnoremap <leader>q :q<cr>
nnoremap <leader>ig gg=G<cr>

" file configuration
nnoremap <leader>e :edit 
nnoremap <leader>w :w!<cr>
nnoremap <leader><s-w> :w
nnoremap <leader>cp :close<cr>

" switch to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>

" tab configuration
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>te :tabedit 
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove
nnoremap <leader>tl :tabn<cr>
nnoremap <leader>th :tabp<cr>

" nerdtree configuration
nnoremap <f4> :NERDTree<cr>
nnoremap <leader>nt :NERDTree<cr>

" gundo configuration
nnoremap <f5> :GundoToggle<cr>

" sessions
nnoremap <leader>mks :mksession!

" ariline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
